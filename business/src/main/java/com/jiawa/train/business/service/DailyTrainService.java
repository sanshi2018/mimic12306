package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.ObjectUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.common.context.LoginMemberContext;
import com.jiawa.train.common.resp.PageResp;
import com.jiawa.train.business.resp.DailyTrainQueryResp;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.business.entity.DailyTrain;
import com.jiawa.train.business.entity.DailyTrainExample;
import com.jiawa.train.business.mapper.DailyTrainMapper;
import com.jiawa.train.business.req.DailyTrainQueryReq;
import com.jiawa.train.business.req.DailyTrainSaveReq;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class DailyTrainService {
    @Resource
    DailyTrainMapper dailyTrainMapper;

    public Long save(DailyTrainSaveReq req) {
        DateTime now = DateTime.now();

        DailyTrain dailyTrain = BeanUtil.copyProperties(req, DailyTrain.class);
        dailyTrain.setUpdateTime(now);
        if(ObjectUtil.isNull(dailyTrain.getId())) {
            dailyTrain.setId(SnowUtil.getId());
            dailyTrain.setCreateTime(now);
            dailyTrainMapper.insert(dailyTrain);
        } else {
            dailyTrainMapper.updateByPrimaryKey(dailyTrain);
        }

        return dailyTrain.getId();
    }

    public int delete(Long id) {
        return dailyTrainMapper.deleteByPrimaryKey(id);
    }

    public PageResp<DailyTrainQueryResp> queryList(DailyTrainQueryReq req) {
        DailyTrainExample example = new DailyTrainExample();
        example.setOrderByClause("id desc");
        DailyTrainExample.Criteria criteria = example.createCriteria();

        // 拦截最近的sql查询，进行分页
        PageHelper.startPage(req.getPage(), req.getSize());
        List<DailyTrain> dailyTrains = dailyTrainMapper.selectByExample(example);
        // 获取查询详情
        PageInfo<DailyTrain> pageInfo = new PageInfo<>(dailyTrains);

        List<DailyTrainQueryResp> list = BeanUtil.copyToList(dailyTrains, DailyTrainQueryResp.class);

        PageResp<DailyTrainQueryResp> pageResp = new PageResp<>();
        pageResp.setTotal(pageInfo.getTotal());
        pageResp.setList(list);
        return pageResp;

    }
}
