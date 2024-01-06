package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.business.enums.SeatColEnum;
import com.jiawa.train.common.context.LoginMemberContext;
import com.jiawa.train.common.exception.BusinessException;
import com.jiawa.train.common.exception.EBusinessException;
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

        TrainCarriage trainCarriageDB = selectByUnique(req.getTrainCode(), req.getIndex());
        if (ObjectUtil.isNotEmpty(trainCarriageDB)) {
            throw new BusinessException(EBusinessException.BUSINESS_TRAIN_CARRIAGE_INDEX_UNIQUE_ERROR);
        }

        // 自动计算出列数和和总座位数
        List<SeatColEnum> seatColEnums = SeatColEnum.getColsByType(req.getSeatType());
        req.setColCount(seatColEnums.size());
        req.setSeatCount(req.getColCount() * req.getRowCount());

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
//        example.setOrderByClause("id desc");
        example.setOrderByClause("train_code asc, `index` asc");
        TrainCarriageExample.Criteria criteria = example.createCriteria();
        if (StrUtil.isNotEmpty(req.getTrainCode())) {
            criteria.andTrainCodeEqualTo(req.getTrainCode());
        }

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

    public List<TrainCarriage> selectByTrainCode(String trainCode) {
        TrainCarriageExample example = new TrainCarriageExample();
        TrainCarriageExample.Criteria criteria = example.createCriteria();
        criteria.andTrainCodeEqualTo(trainCode);
        return trainCarriageMapper.selectByExample(example);
    }

    private TrainCarriage selectByUnique(String trainCode, Integer index) {
        TrainCarriageExample trainCarriageExample = new TrainCarriageExample();
        trainCarriageExample.createCriteria()
                .andTrainCodeEqualTo(trainCode)
                .andIndexEqualTo(index);
        List<TrainCarriage> list = trainCarriageMapper.selectByExample(trainCarriageExample);
        if (CollUtil.isNotEmpty(list)) {
            return list.get(0);
        } else {
            return null;
        }
    }
}
