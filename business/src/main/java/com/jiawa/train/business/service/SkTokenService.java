package com.jiawa.train.business.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.ObjectUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.common.context.LoginMemberContext;
import com.jiawa.train.common.resp.PageResp;
import com.jiawa.train.business.resp.SkTokenQueryResp;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.business.entity.SkToken;
import com.jiawa.train.business.entity.SkTokenExample;
import com.jiawa.train.business.mapper.SkTokenMapper;
import com.jiawa.train.business.req.SkTokenQueryReq;
import com.jiawa.train.business.req.SkTokenSaveReq;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class SkTokenService {
    @Resource
    SkTokenMapper skTokenMapper;

    public Long save(SkTokenSaveReq req) {
        DateTime now = DateTime.now();

        SkToken skToken = BeanUtil.copyProperties(req, SkToken.class);
        skToken.setUpdateTime(now);
        if(ObjectUtil.isNull(skToken.getId())) {
            skToken.setId(SnowUtil.getId());
            skToken.setCreateTime(now);
            skTokenMapper.insert(skToken);
        } else {
            skTokenMapper.updateByPrimaryKey(skToken);
        }

        return skToken.getId();
    }

    public int delete(Long id) {
        return skTokenMapper.deleteByPrimaryKey(id);
    }

    public PageResp<SkTokenQueryResp> queryList(SkTokenQueryReq req) {
        SkTokenExample example = new SkTokenExample();
        example.setOrderByClause("id desc");
        SkTokenExample.Criteria criteria = example.createCriteria();

        // 拦截最近的sql查询，进行分页
        PageHelper.startPage(req.getPage(), req.getSize());
        List<SkToken> skTokens = skTokenMapper.selectByExample(example);
        // 获取查询详情
        PageInfo<SkToken> pageInfo = new PageInfo<>(skTokens);

        List<SkTokenQueryResp> list = BeanUtil.copyToList(skTokens, SkTokenQueryResp.class);

        PageResp<SkTokenQueryResp> pageResp = new PageResp<>();
        pageResp.setTotal(pageInfo.getTotal());
        pageResp.setList(list);
        return pageResp;

    }
}
