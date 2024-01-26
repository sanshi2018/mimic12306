package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.business.entity.DailyTrainStation;
import com.jiawa.train.business.entity.Train;
import com.jiawa.train.business.entity.TrainExample;
import com.jiawa.train.business.mapper.TrainMapper;
import com.jiawa.train.business.resp.TrainQueryResp;
import com.jiawa.train.common.context.LoginMemberContext;
import com.jiawa.train.common.resp.PageResp;
import com.jiawa.train.business.resp.DailyTrainQueryResp;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.business.entity.DailyTrain;
import com.jiawa.train.business.entity.DailyTrainExample;
import com.jiawa.train.business.mapper.DailyTrainMapper;
import com.jiawa.train.business.req.DailyTrainQueryReq;
import com.jiawa.train.business.req.DailyTrainSaveReq;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class DailyTrainService {
    @Resource
    private DailyTrainMapper dailyTrainMapper;
    @Resource
    private TrainService trainService;
    @Resource
    private DailyTrainStationService dailyTrainStationService;
    @Resource
    private DailyTrainCarriageService dailyTrainCarriageService;

    public Long save(DailyTrainSaveReq req) {
        DateTime now = DateTime.now();

        DailyTrain dailyTrain = BeanUtil.copyProperties(req, DailyTrain.class);
        dailyTrain.setUpdateTime(now);
        if(ObjectUtil.isNull(dailyTrain.getId())) {
            dailyTrain.setId(SnowUtil.getId());
            dailyTrain.setCreateTime(now);
            dailyTrainMapper.insert(dailyTrain);
        } else {
            dailyTrainMapper.updateByPrimaryKey(dailyTrain);
        }

        return dailyTrain.getId();
    }

    public int delete(Long id) {
        return dailyTrainMapper.deleteByPrimaryKey(id);
    }

    public PageResp<DailyTrainQueryResp> queryList(DailyTrainQueryReq req) {
        DailyTrainExample example = new DailyTrainExample();
        example.setOrderByClause("date desc, code asc");
        DailyTrainExample.Criteria criteria = example.createCriteria();
        if (ObjectUtil.isNotNull(req.getDate())) {
            criteria.andDateEqualTo(req.getDate());
        }

        if (ObjectUtil.isNotEmpty(req.getCode())) {
            criteria.andCodeEqualTo(req.getCode());
        }

        // 拦截最近的sql查询，进行分页
        PageHelper.startPage(req.getPage(), req.getSize());
        List<DailyTrain> dailyTrains = dailyTrainMapper.selectByExample(example);
        // 获取查询详情
        PageInfo<DailyTrain> pageInfo = new PageInfo<>(dailyTrains);

        List<DailyTrainQueryResp> list = BeanUtil.copyToList(dailyTrains, DailyTrainQueryResp.class);

        PageResp<DailyTrainQueryResp> pageResp = new PageResp<>();
        pageResp.setTotal(pageInfo.getTotal());
        pageResp.setList(list);
        return pageResp;

    }

    public void genDaily(Date date) {
        List<Train> trainList = trainService.selectAll();
        if (CollUtil.isEmpty(trainList)) {
            log.info("没有车次基础数据，任务结束");
            return;
        }

        for (Train train : trainList) {
            genDailyTrain(date, train);
        }
    }

    public void genDailyTrain(Date date, Train train) {
        log.info("生成日期【{}】车次【{}】的信息开始", DateUtil.formatDate(date), train.getCode());
        DailyTrainExample dailyTrainExample = new DailyTrainExample();
        dailyTrainExample.createCriteria()
                .andDateEqualTo(date)
                .andCodeEqualTo(train.getCode());

        dailyTrainMapper.deleteByExample(dailyTrainExample);

        // 生成该车次的数据
        DateTime now = DateTime.now();
        DailyTrain dailyTrain = BeanUtil.copyProperties(train, DailyTrain.class);
        dailyTrain.setId(SnowUtil.getId());
        dailyTrain.setCreateTime(now);
        dailyTrain.setUpdateTime(now);
        dailyTrain.setDate(date);

        dailyTrainMapper.insert(dailyTrain);

        // 生成车站数据
        dailyTrainStationService.genDaily(date, train.getCode());
        // 生成车厢数据
        dailyTrainCarriageService.genDaily(date, train.getCode());

        log.info("生成日期【{}】车次【{}】的信息结束", DateUtil.formatDate(date), train.getCode());
    }

}
