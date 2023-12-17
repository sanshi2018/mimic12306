package com.jiawa.train.member.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.ObjectUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.common.context.LoginMemberContext;
import com.jiawa.train.common.resp.PageResp;
import com.jiawa.train.common.resp.PassengerQueryResp;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.member.entity.Passenger;
import com.jiawa.train.member.entity.PassengerExample;
import com.jiawa.train.member.mapper.PassengerMapper;
import com.jiawa.train.member.req.PassengerQueryReq;
import com.jiawa.train.member.req.PassengerReq;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class PassengerService {
    @Resource
    PassengerMapper passengerMapper;

    public Long save(PassengerReq req) {
        DateTime now = DateTime.now();

        Passenger passenger = BeanUtil.copyProperties(req, Passenger.class);
        passenger.setUpdateTime(now);
        if(ObjectUtil.isNotNull(passenger.getId())) {
            passenger.setMemberId(LoginMemberContext.getId());
            passenger.setId(SnowUtil.getId());
            passenger.setCreateTime(now);
            passengerMapper.insert(passenger);
        } else {
            passengerMapper.updateByPrimaryKey(passenger);
        }

        return passenger.getId();
    }

    public PageResp<PassengerQueryResp> queryList(PassengerQueryReq req) {
        PassengerExample example = new PassengerExample();
        example.setOrderByClause("id desc");
        PassengerExample.Criteria criteria = example.createCriteria();
        if (ObjectUtil.isNotNull(req.getMemberId())) {
            criteria.andMemberIdEqualTo(req.getMemberId());
        }
        // 拦截最近的sql查询，进行分页
        PageHelper.startPage(req.getPage(), req.getSize());
        List<Passenger> passengers = passengerMapper.selectByExample(example);
        // 获取查询详情
        PageInfo<Passenger> pageInfo = new PageInfo<>(passengers);

        List<PassengerQueryResp> list = BeanUtil.copyToList(passengers, PassengerQueryResp.class);

        PageResp<PassengerQueryResp> pageResp = new PageResp<>();
        pageResp.setTotal(pageInfo.getTotal());
        pageResp.setList(list);
        return pageResp;

    }
}
