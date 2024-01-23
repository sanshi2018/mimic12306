package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.ObjectUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.common.context.LoginMemberContext;
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

import java.util.List;

@Slf4j
@Service
public class DailyTrainSeatService {
    @Resource
    DailyTrainSeatMapper dailyTrainSeatMapper;

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
        example.setOrderByClause("id desc");
        DailyTrainSeatExample.Criteria criteria = example.createCriteria();

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
}
