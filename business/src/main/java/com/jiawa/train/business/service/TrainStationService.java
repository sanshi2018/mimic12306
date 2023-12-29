package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.ObjectUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.common.context.LoginMemberContext;
import com.jiawa.train.common.resp.PageResp;
import com.jiawa.train.business.resp.TrainStationQueryResp;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.business.entity.TrainStation;
import com.jiawa.train.business.entity.TrainStationExample;
import com.jiawa.train.business.mapper.TrainStationMapper;
import com.jiawa.train.business.req.TrainStationQueryReq;
import com.jiawa.train.business.req.TrainStationSaveReq;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class TrainStationService {
    @Resource
    TrainStationMapper trainStationMapper;

    public Long save(TrainStationSaveReq req) {
        DateTime now = DateTime.now();

        TrainStation trainStation = BeanUtil.copyProperties(req, TrainStation.class);
        trainStation.setUpdateTime(now);
        if(ObjectUtil.isNull(trainStation.getId())) {
            trainStation.setId(SnowUtil.getId());
            trainStation.setCreateTime(now);
            trainStationMapper.insert(trainStation);
        } else {
            trainStationMapper.updateByPrimaryKey(trainStation);
        }

        return trainStation.getId();
    }

    public int delete(Long id) {
        return trainStationMapper.deleteByPrimaryKey(id);
    }

    public PageResp<TrainStationQueryResp> queryList(TrainStationQueryReq req) {
        TrainStationExample example = new TrainStationExample();
        example.setOrderByClause("id desc");
        TrainStationExample.Criteria criteria = example.createCriteria();

        // 拦截最近的sql查询，进行分页
        PageHelper.startPage(req.getPage(), req.getSize());
        List<TrainStation> trainStations = trainStationMapper.selectByExample(example);
        // 获取查询详情
        PageInfo<TrainStation> pageInfo = new PageInfo<>(trainStations);

        List<TrainStationQueryResp> list = BeanUtil.copyToList(trainStations, TrainStationQueryResp.class);

        PageResp<TrainStationQueryResp> pageResp = new PageResp<>();
        pageResp.setTotal(pageInfo.getTotal());
        pageResp.setList(list);
        return pageResp;

    }
}
