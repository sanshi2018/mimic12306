package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.ObjectUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.common.context.LoginMemberContext;
import com.jiawa.train.common.resp.PageResp;
import com.jiawa.train.business.resp.StationQueryResp;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.business.entity.Station;
import com.jiawa.train.business.entity.StationExample;
import com.jiawa.train.business.mapper.StationMapper;
import com.jiawa.train.business.req.StationQueryReq;
import com.jiawa.train.business.req.StationSaveReq;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class StationService {
    @Resource
    StationMapper stationMapper;

    public Long save(StationSaveReq req) {
        DateTime now = DateTime.now();

        Station station = BeanUtil.copyProperties(req, Station.class);
        station.setUpdateTime(now);
        if(ObjectUtil.isNull(station.getId())) {
            station.setId(SnowUtil.getId());
            station.setCreateTime(now);
            stationMapper.insert(station);
        } else {
            stationMapper.updateByPrimaryKey(station);
        }

        return station.getId();
    }

    public int delete(Long id) {
        return stationMapper.deleteByPrimaryKey(id);
    }

    public PageResp<StationQueryResp> queryList(StationQueryReq req) {
        StationExample example = new StationExample();
        example.setOrderByClause("id desc");
        StationExample.Criteria criteria = example.createCriteria();

        // 拦截最近的sql查询，进行分页
        PageHelper.startPage(req.getPage(), req.getSize());
        List<Station> stations = stationMapper.selectByExample(example);
        // 获取查询详情
        PageInfo<Station> pageInfo = new PageInfo<>(stations);

        List<StationQueryResp> list = BeanUtil.copyToList(stations, StationQueryResp.class);

        PageResp<StationQueryResp> pageResp = new PageResp<>();
        pageResp.setTotal(pageInfo.getTotal());
        pageResp.setList(list);
        return pageResp;

    }
}
