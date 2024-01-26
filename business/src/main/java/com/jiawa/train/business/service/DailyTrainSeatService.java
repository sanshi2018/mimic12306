package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.business.entity.DailyTrainCarriage;
import com.jiawa.train.business.entity.DailyTrainCarriageExample;
import com.jiawa.train.business.entity.TrainCarriage;
import com.jiawa.train.business.entity.TrainSeat;
import com.jiawa.train.common.resp.PageResp;
import com.jiawa.train.business.resp.DailyTrainSeatQueryResp;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.business.entity.DailyTrainSeat;
import com.jiawa.train.business.entity.DailyTrainSeatExample;
import com.jiawa.train.business.mapper.DailyTrainSeatMapper;
import com.jiawa.train.business.req.DailyTrainSeatQueryReq;
import com.jiawa.train.business.req.DailyTrainSeatSaveReq;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Slf4j
@Service
public class DailyTrainSeatService {
    @Resource
    DailyTrainSeatMapper dailyTrainSeatMapper;
    @Resource
    private TrainSeatService trainSeatService;
    @Resource
    private TrainStationService trainStationService;

    public Long save(DailyTrainSeatSaveReq req) {
        DateTime now = DateTime.now();

        DailyTrainSeat dailyTrainSeat = BeanUtil.copyProperties(req, DailyTrainSeat.class);
        dailyTrainSeat.setUpdateTime(now);
        if(ObjectUtil.isNull(dailyTrainSeat.getId())) {
            dailyTrainSeat.setId(SnowUtil.getId());
            dailyTrainSeat.setCreateTime(now);
            dailyTrainSeatMapper.insert(dailyTrainSeat);
        } else {
            dailyTrainSeatMapper.updateByPrimaryKey(dailyTrainSeat);
        }

        return dailyTrainSeat.getId();
    }

    public int delete(Long id) {
        return dailyTrainSeatMapper.deleteByPrimaryKey(id);
    }

    public PageResp<DailyTrainSeatQueryResp> queryList(DailyTrainSeatQueryReq req) {
        DailyTrainSeatExample example = new DailyTrainSeatExample();
        example.setOrderByClause("train_code asc, carriage_index asc, carriage_seat_index asc");
        DailyTrainSeatExample.Criteria criteria = example.createCriteria();
        if (ObjectUtil.isNotNull(req.getTrainCode()))
        {
            criteria.andTrainCodeEqualTo(req.getTrainCode());
        }

        // 拦截最近的sql查询，进行分页
        PageHelper.startPage(req.getPage(), req.getSize());
        List<DailyTrainSeat> dailyTrainSeats = dailyTrainSeatMapper.selectByExample(example);
        // 获取查询详情
        PageInfo<DailyTrainSeat> pageInfo = new PageInfo<>(dailyTrainSeats);

        List<DailyTrainSeatQueryResp> list = BeanUtil.copyToList(dailyTrainSeats, DailyTrainSeatQueryResp.class);

        PageResp<DailyTrainSeatQueryResp> pageResp = new PageResp<>();
        pageResp.setTotal(pageInfo.getTotal());
        pageResp.setList(list);
        return pageResp;

    }

    public void genDaily(Date date, String trainCode) {
        log.info("========================生成日期【{}】车次【{}】的座位信息开始======================================", DateUtil.formatDate(date), trainCode);

        // 查出某车次的所有车厢信息
        List<TrainSeat> seatList = trainSeatService.selectByTrainCode(trainCode);
        if (CollUtil.isEmpty(seatList)) {
            log.info("车次:{},没有车座基础数据", trainCode);
            return;
        }

        // 删除某日某车次的座位信息
        DailyTrainSeatExample dailyTrainSeatExample = new DailyTrainSeatExample();
        dailyTrainSeatExample.createCriteria()
                .andDateEqualTo(date)
                .andTrainCodeEqualTo(trainCode);

        dailyTrainSeatMapper.deleteByExample(dailyTrainSeatExample);

        String sell = StrUtil.fillBefore("", '0', seatList.size() - 1);

        for (TrainSeat trainSeat : seatList) {
            DateTime now = DateTime.now();
            DailyTrainSeat dailyTrainSeat = BeanUtil.copyProperties(trainSeat, DailyTrainSeat.class);
            dailyTrainSeat.setId(SnowUtil.getId());
            dailyTrainSeat.setCreateTime(now);
            dailyTrainSeat.setUpdateTime(now);
            dailyTrainSeat.setDate(date);
            dailyTrainSeat.setSell(sell);
            dailyTrainSeatMapper.insert(dailyTrainSeat);
        }


        log.info("========================生成日期【{}】车次【{}】的座位信息开始======================================", DateUtil.formatDate(date), trainCode);

    }
}
