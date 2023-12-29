package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.ObjectUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.common.context.LoginMemberContext;
import com.jiawa.train.common.resp.PageResp;
import com.jiawa.train.business.resp.TrainQueryResp;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.business.entity.Train;
import com.jiawa.train.business.entity.TrainExample;
import com.jiawa.train.business.mapper.TrainMapper;
import com.jiawa.train.business.req.TrainQueryReq;
import com.jiawa.train.business.req.TrainSaveReq;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class TrainService {
    @Resource
    TrainMapper trainMapper;

    public Long save(TrainSaveReq req) {
        DateTime now = DateTime.now();

        Train train = BeanUtil.copyProperties(req, Train.class);
        train.setUpdateTime(now);
        if(ObjectUtil.isNull(train.getId())) {
            train.setId(SnowUtil.getId());
            train.setCreateTime(now);
            trainMapper.insert(train);
        } else {
            trainMapper.updateByPrimaryKey(train);
        }

        return train.getId();
    }

    public int delete(Long id) {
        return trainMapper.deleteByPrimaryKey(id);
    }

    public PageResp<TrainQueryResp> queryList(TrainQueryReq req) {
        TrainExample example = new TrainExample();
        example.setOrderByClause("id desc");
        TrainExample.Criteria criteria = example.createCriteria();

        // 拦截最近的sql查询，进行分页
        PageHelper.startPage(req.getPage(), req.getSize());
        List<Train> trains = trainMapper.selectByExample(example);
        // 获取查询详情
        PageInfo<Train> pageInfo = new PageInfo<>(trains);

        List<TrainQueryResp> list = BeanUtil.copyToList(trains, TrainQueryResp.class);

        PageResp<TrainQueryResp> pageResp = new PageResp<>();
        pageResp.setTotal(pageInfo.getTotal());
        pageResp.setList(list);
        return pageResp;

    }

    public List<TrainQueryResp> queryAll() {
        TrainExample example = new TrainExample();
        example.setOrderByClause("code desc");
        List<Train> trains = trainMapper.selectByExample(example);
        return BeanUtil.copyToList(trains, TrainQueryResp.class);
    }
}
