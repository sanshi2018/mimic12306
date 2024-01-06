package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.business.entity.TrainCarriage;
import com.jiawa.train.business.enums.SeatColEnum;
import com.jiawa.train.common.context.LoginMemberContext;
import com.jiawa.train.common.resp.PageResp;
import com.jiawa.train.business.resp.TrainSeatQueryResp;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.business.entity.TrainSeat;
import com.jiawa.train.business.entity.TrainSeatExample;
import com.jiawa.train.business.mapper.TrainSeatMapper;
import com.jiawa.train.business.req.TrainSeatQueryReq;
import com.jiawa.train.business.req.TrainSeatSaveReq;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class TrainSeatService {
    @Resource
    TrainSeatMapper trainSeatMapper;
    @Resource
    TrainCarriageService trainCarriageService;

    public Long save(TrainSeatSaveReq req) {
        DateTime now = DateTime.now();

        TrainSeat trainSeat = BeanUtil.copyProperties(req, TrainSeat.class);
        trainSeat.setUpdateTime(now);
        if(ObjectUtil.isNull(trainSeat.getId())) {
            trainSeat.setId(SnowUtil.getId());
            trainSeat.setCreateTime(now);
            trainSeatMapper.insert(trainSeat);
        } else {
            trainSeatMapper.updateByPrimaryKey(trainSeat);
        }

        return trainSeat.getId();
    }

    public int delete(Long id) {
        return trainSeatMapper.deleteByPrimaryKey(id);
    }

    public PageResp<TrainSeatQueryResp> queryList(TrainSeatQueryReq req) {
        TrainSeatExample example = new TrainSeatExample();
//        example.setOrderByClause("id desc");
        example.setOrderByClause("train_code asc, 'index' asc");
        TrainSeatExample.Criteria criteria = example.createCriteria();
        if (StrUtil.isNotEmpty(req.getTrainCode())) {
            criteria.andTrainCodeEqualTo(req.getTrainCode());
        }

        // 拦截最近的sql查询，进行分页
        PageHelper.startPage(req.getPage(), req.getSize());
        List<TrainSeat> trainSeats = trainSeatMapper.selectByExample(example);
        // 获取查询详情
        PageInfo<TrainSeat> pageInfo = new PageInfo<>(trainSeats);

        List<TrainSeatQueryResp> list = BeanUtil.copyToList(trainSeats, TrainSeatQueryResp.class);

        PageResp<TrainSeatQueryResp> pageResp = new PageResp<>();
        pageResp.setTotal(pageInfo.getTotal());
        pageResp.setList(list);
        return pageResp;

    }

    public void genTrainSeat(String trainCode) {
        DateTime now = DateTime.now();
        // 1. 删除原有的座位信息
        TrainSeatExample trainSeatExample = new TrainSeatExample();
        TrainSeatExample.Criteria criteria = trainSeatExample.createCriteria();
        criteria.andTrainCodeEqualTo(trainCode);
        trainSeatMapper.deleteByExample(trainSeatExample);

        // 查找当前车次下的所有车厢
        List<TrainCarriage> carriages = trainCarriageService.selectByTrainCode(trainCode);
        log.info("当前车次下的车厢数:{}", carriages.size());

        // 循环生成每个车厢的座位
        carriages.forEach(carriage -> {
            // 根据车厢定义的行数列数生成座位
            Integer rowCount = carriage.getRowCount();
            String seatType = carriage.getSeatType();
            int seatIndex = 1;

            // 根据座位类型，筛选出所有的列，比如车厢类型是一等座，则筛选出columnList={ACDF}
            List<SeatColEnum> colsByType = SeatColEnum.getColsByType(seatType);
            log.info("根据车厢的座位类型，筛选出所有的列：{}", colsByType);

            // 循环行数
            for (int row = 1; row <= rowCount; row++) {
                // 循环列数
                for (SeatColEnum cols : colsByType) {
                    TrainSeat trainSeat = new TrainSeat();
                    trainSeat.setId(SnowUtil.getId());
                    trainSeat.setTrainCode(trainCode);
                    trainSeat.setCarriageIndex(carriage.getIndex());
                    trainSeat.setRow(StrUtil.fillBefore(String.valueOf(row), '0', 2));
                    trainSeat.setCol(cols.getCode());
                    trainSeat.setSeatType(seatType);
                    trainSeat.setCarriageSeatIndex(seatIndex++);
                    trainSeat.setCreateTime(now);
                    trainSeat.setUpdateTime(now);

                    trainSeatMapper.insert(trainSeat);

                }
            }
        });
    }
}
