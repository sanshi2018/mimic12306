package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.business.enums.RedisKeyPreEnum;
import com.jiawa.train.business.mapper.cust.SkTokenMapperCust;
import com.jiawa.train.common.exception.BusinessException;
import com.jiawa.train.common.exception.BusinessExceptionEnum;
import com.jiawa.train.common.resp.PageResp;
import com.jiawa.train.business.resp.SkTokenQueryResp;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.business.entity.SkToken;
import com.jiawa.train.business.entity.SkTokenExample;
import com.jiawa.train.business.mapper.SkTokenMapper;
import com.jiawa.train.business.req.SkTokenQueryReq;
import com.jiawa.train.business.req.SkTokenSaveReq;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.redisson.api.RBucket;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.Instant;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Slf4j
@Service
public class SkTokenService {
    @Resource
    SkTokenMapper skTokenMapper;

    @Resource
    private DailyTrainSeatService dailyTrainSeatService;

    @Resource
    private DailyTrainStationService dailyTrainStationService;

    @Resource
    private SkTokenMapperCust skTokenMapperCust;

    @Autowired
    private RedissonClient redissonClient;

    @Value("${spring.profiles.active}")
    private String env;
    /**
     * 初始化
     */
    public void genDaily(Date date, String trainCode) {
        log.info("删除日期【{}】车次【{}】的令牌记录", DateUtil.formatDate(date), trainCode);
        SkTokenExample skTokenExample = new SkTokenExample();
        skTokenExample.createCriteria().andDateEqualTo(date).andTrainCodeEqualTo(trainCode);
        skTokenMapper.deleteByExample(skTokenExample);

        DateTime now = DateTime.now();
        SkToken skToken = new SkToken();
        skToken.setDate(date);
        skToken.setTrainCode(trainCode);
        skToken.setId(SnowUtil.getSnowflakeNextId());
        skToken.setCreateTime(now);
        skToken.setUpdateTime(now);

        int seatCount = dailyTrainSeatService.countSeat(date, trainCode);
        log.info("车次【{}】座位数：{}", trainCode, seatCount);

        long stationCount = dailyTrainStationService.countByTrainCode(date, trainCode);
        log.info("车次【{}】到站数：{}", trainCode, stationCount);

        // 3/4需要根据实际卖票比例来定，一趟火车最多可以卖（seatCount * stationCount）张火车票
        int count = (int) (seatCount * stationCount);
        log.info("车次【{}】初始生成令牌数：{}", trainCode, count);
        skToken.setCount(count);

        skTokenMapper.insert(skToken);
    }

    public Long save(SkTokenSaveReq req) {
        DateTime now = DateTime.now();

        SkToken skToken = BeanUtil.copyProperties(req, SkToken.class);
        skToken.setUpdateTime(now);
        if (ObjectUtil.isNull(skToken.getId())) {
            skToken.setId(SnowUtil.getSnowflakeNextId());
            skToken.setCreateTime(now);
            skTokenMapper.insert(skToken);
        } else {
            skTokenMapper.updateByPrimaryKey(skToken);
        }

        return skToken.getId();
    }

    public int delete(Long id) {
        return skTokenMapper.deleteByPrimaryKey(id);
    }

    public PageResp<SkTokenQueryResp> queryList(SkTokenQueryReq req) {
        SkTokenExample example = new SkTokenExample();
        example.setOrderByClause("id desc");
        SkTokenExample.Criteria criteria = example.createCriteria();

        // 拦截最近的sql查询，进行分页
        PageHelper.startPage(req.getPage(), req.getSize());
        List<SkToken> skTokens = skTokenMapper.selectByExample(example);
        // 获取查询详情
        PageInfo<SkToken> pageInfo = new PageInfo<>(skTokens);

        List<SkTokenQueryResp> list = BeanUtil.copyToList(skTokens, SkTokenQueryResp.class);

        PageResp<SkTokenQueryResp> pageResp = new PageResp<>();
        pageResp.setTotal(pageInfo.getTotal());
        pageResp.setList(list);
        return pageResp;

    }


    /**
     * 获取令牌
     */
    public boolean validSkToken(Date date, String trainCode, Long memberId) {
        log.info("会员【{}】获取日期【{}】车次【{}】的令牌开始", memberId, DateUtil.formatDate(date), trainCode);

        if (!env.equals("dev")) {

        }

        // 先获取令牌锁，再校验令牌余量，防止机器人抢票，lockKey就是令牌，用来表示【谁能做什么】的一个凭证
        String lockKey = RedisKeyPreEnum.SK_TOKEN + "-" + DateUtil.formatDate(date) + "-" + trainCode + "-" + memberId;
        RLock lock = null;
        try {
            // 使用redisson，自带看门狗
            lock = redissonClient.getLock(lockKey);
            // 防止刷票，拿到锁后5s后才自动释放锁
            boolean tryLock = lock.tryLock(0,15, TimeUnit.SECONDS);
            if (tryLock) {
                log.info("恭喜，抢到锁了！");
                log.info("会员【{}】获取日期【{}】车次【{}】的令牌开始", memberId, DateUtil.formatDate(date), trainCode);

                String skTokenCountKey = RedisKeyPreEnum.SK_TOKEN_COUNT + "-" + DateUtil.formatDate(date) + "-" + trainCode;
                // 获取skTokenCountKey的值 从redis中
                RBucket<Long> skTokenCount = redissonClient.getBucket(skTokenCountKey);
                if (skTokenCount.isExists()) {
                    log.info("缓存中有该车次令牌大闸的key：{}", skTokenCountKey);
                    Long count = skTokenCount.getAndSet(skTokenCount.get() - 1);


                    if (count < 0L) {
                        log.error("获取令牌失败：{}", skTokenCountKey);
                        return false;
//                        throw new BusinessException(BusinessExceptionEnum.CONFIRM_ORDER_SK_TOKEN_FAIL);
                    } else {
                        log.info("获取令牌后，令牌余数：{}", count);
                        // 设置对象60s过期
                        skTokenCount.expire(Duration.ofSeconds(60));
                        // 每取5个令牌更新一次数据库
                        if (count % 5 == 0) {
                            skTokenMapperCust.decrease(date, trainCode, 5);
                        }
                        return true;
                    }
                } else {
                    log.info("缓存中没有该车次令牌大闸的key：{}", skTokenCountKey);
                    // 检查是否还有令牌
                    SkTokenExample skTokenExample = new SkTokenExample();
                    skTokenExample.createCriteria().andDateEqualTo(date).andTrainCodeEqualTo(trainCode);
                    List<SkToken> skTokens = skTokenMapper.selectByExample(skTokenExample);
                    if (CollUtil.isEmpty(skTokens)) {
                        log.info("找不到日期【{}】车次【{}】的令牌记录", DateUtil.formatDate(date), trainCode);
                        return false;
                    }

                    SkToken skToken = skTokens.get(0);
                    if (skToken.getCount() <= 0) {
                        log.info("日期【{}】车次【{}】的令牌余量为0", DateUtil.formatDate(date), trainCode);
                        return false;
                    }

                    // 令牌还有余量
                    // 令牌-1
                    int count = skToken.getCount() - 1;
                    skToken.setCount(count);
                    log.info("将该车次令牌大闸放入缓存中，key: {}， count: {}", skTokenCountKey, count);
                    // 不需要更新数据库，只要放缓存即可
                    skTokenCount.setAsync((long) count, 60, TimeUnit.SECONDS);
//                    skTokenMapper.updateByPrimaryKey(skToken);
                    return true;
                }

            } else {
                // 只是没抢到锁，并不知道票抢完了没，所以提示稍候再试
                log.info("很遗憾，没抢到锁");
                throw new BusinessException(BusinessExceptionEnum.CONFIRM_ORDER_LOCK_FAIL);
            }

        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        finally {
            log.info("购票流程结束，释放锁！");
            if (null != lock && lock.isHeldByCurrentThread()) {
                lock.unlock();
            }
        }


    }
}
