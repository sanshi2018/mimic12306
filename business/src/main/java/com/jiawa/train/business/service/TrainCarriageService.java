package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.ObjectUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.common.context.LoginMemberContext;
import com.jiawa.train.common.resp.PageResp;
import com.jiawa.train.business.resp.TrainCarriageQueryResp;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.business.entity.TrainCarriage;
import com.jiawa.train.business.entity.TrainCarriageExample;
import com.jiawa.train.business.mapper.TrainCarriageMapper;
import com.jiawa.train.business.req.TrainCarriageQueryReq;
import com.jiawa.train.business.req.TrainCarriageSaveReq;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class TrainCarriageService {
    @Resource
    TrainCarriageMapper trainCarriageMapper;

    public Long save(TrainCarriageSaveReq req) {
        DateTime now = DateTime.now();

        TrainCarriage trainCarriage = BeanUtil.copyProperties(req, TrainCarriage.class);
        trainCarriage.setUpdateTime(now);
        if(ObjectUtil.isNull(trainCarriage.getId())) {
            trainCarriage.setId(SnowUtil.getId());
            trainCarriage.setCreateTime(now);
            trainCarriageMapper.insert(trainCarriage);
        } else {
            trainCarriageMapper.updateByPrimaryKey(trainCarriage);
        }

        return trainCarriage.getId();
    }

    public int delete(Long id) {
        return trainCarriageMapper.deleteByPrimaryKey(id);
    }

    public PageResp<TrainCarriageQueryResp> queryList(TrainCarriageQueryReq req) {
        TrainCarriageExample example = new TrainCarriageExample();
        example.setOrderByClause("id desc");
        TrainCarriageExample.Criteria criteria = example.createCriteria();

        // 拦截最近的sql查询，进行分页
        PageHelper.startPage(req.getPage(), req.getSize());
        List<TrainCarriage> trainCarriages = trainCarriageMapper.selectByExample(example);
        // 获取查询详情
        PageInfo<TrainCarriage> pageInfo = new PageInfo<>(trainCarriages);

        List<TrainCarriageQueryResp> list = BeanUtil.copyToList(trainCarriages, TrainCarriageQueryResp.class);

        PageResp<TrainCarriageQueryResp> pageResp = new PageResp<>();
        pageResp.setTotal(pageInfo.getTotal());
        pageResp.setList(list);
        return pageResp;

    }
}
