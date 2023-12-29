package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.ObjectUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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
        example.setOrderByClause("id desc");
        TrainSeatExample.Criteria criteria = example.createCriteria();

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
}
