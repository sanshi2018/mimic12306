package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.common.context.LoginMemberContext;
import com.jiawa.train.common.exception.BusinessException;
import com.jiawa.train.common.exception.EBusinessException;
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
import org.springframework.util.StringUtils;

import java.util.List;

@Slf4j
@Service
public class TrainStationService {
    @Resource
    TrainStationMapper trainStationMapper;

    public Long save(TrainStationSaveReq req) {
        DateTime now = DateTime.now();

        // 保存之前，先校验唯一键是否存在
        TrainStation trainStationDB = selectByUnique(req.getTrainCode(), req.getIndex());
        if (ObjectUtil.isNotEmpty(trainStationDB)) {
            throw new BusinessException(EBusinessException.BUSINESS_TRAIN_STATION_INDEX_UNIQUE_ERROR);
        }
        // 保存之前，先校验唯一键是否存在
        trainStationDB = selectByUnique(req.getTrainCode(), req.getName());
        if (ObjectUtil.isNotEmpty(trainStationDB)) {
            throw new BusinessException(EBusinessException.BUSINESS_TRAIN_STATION_NAME_UNIQUE_ERROR);
        }

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
//        example.setOrderByClause("id desc");
        example.setOrderByClause("train_code asc, 'index' asc");

        TrainStationExample.Criteria criteria = example.createCriteria();

        if (StrUtil.isNotEmpty(req.getTrainCode())) {
            criteria.andTrainCodeEqualTo(req.getTrainCode());
        }
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


    private TrainStation selectByUnique(String trainCode, Integer index) {
        TrainStationExample trainStationExample = new TrainStationExample();
        trainStationExample.createCriteria()
                .andTrainCodeEqualTo(trainCode)
                .andIndexEqualTo(index);
        List<TrainStation> list = trainStationMapper.selectByExample(trainStationExample);
        if (CollUtil.isNotEmpty(list)) {
            return list.get(0);
        } else {
            return null;
        }
    }

    private TrainStation selectByUnique(String trainCode, String name) {
        TrainStationExample trainStationExample = new TrainStationExample();
        trainStationExample.createCriteria()
                .andTrainCodeEqualTo(trainCode)
                .andNameEqualTo(name);
        List<TrainStation> list = trainStationMapper.selectByExample(trainStationExample);
        if (CollUtil.isNotEmpty(list)) {
            return list.get(0);
        } else {
            return null;
        }
    }

    public List<TrainStation> selectByTrainCode(String trainCode) {
        TrainStationExample trainStationExample = new TrainStationExample();
        trainStationExample.createCriteria()
                .andTrainCodeEqualTo(trainCode);

        return trainStationMapper.selectByExample(trainStationExample);
    }

}
