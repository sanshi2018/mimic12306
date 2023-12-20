package com.jiawa.train.member.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.util.ObjectUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jiawa.train.common.context.LoginMemberContext;
import com.jiawa.train.common.resp.PageResp;
import com.jiawa.train.common.resp.${Domain}QueryResp;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.member.entity.${Domain};
import com.jiawa.train.member.entity.${Domain}Example;
import com.jiawa.train.member.mapper.${Domain}Mapper;
import com.jiawa.train.member.req.${Domain}QueryReq;
import com.jiawa.train.member.req.${Domain}SaveReq;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
public class ${Domain}Service {
    @Resource
    ${Domain}Mapper ${domain}Mapper;

    public Long save(${Domain}SaveReq req) {
        DateTime now = DateTime.now();

        ${Domain} ${domain} = BeanUtil.copyProperties(req, ${Domain}.class);
        ${domain}.setUpdateTime(now);
        if(ObjectUtil.isNull(${domain}.getId())) {
            ${domain}.setMemberId(LoginMemberContext.getId());
            ${domain}.setId(SnowUtil.getId());
            ${domain}.setCreateTime(now);
            ${domain}Mapper.insert(${domain});
        } else {
            ${domain}Mapper.updateByPrimaryKey(${domain});
        }

        return ${domain}.getId();
    }

    public int delete(Long id) {
        return ${domain}Mapper.deleteByPrimaryKey(id);
    }

    public PageResp<${Domain}QueryResp> queryList(${Domain}QueryReq req) {
        ${Domain}Example example = new ${Domain}Example();
        example.setOrderByClause("id desc");
        ${Domain}Example.Criteria criteria = example.createCriteria();
        if (ObjectUtil.isNotNull(req.getMemberId())) {
            criteria.andMemberIdEqualTo(req.getMemberId());
        }
        // 拦截最近的sql查询，进行分页
        PageHelper.startPage(req.getPage(), req.getSize());
        List<${Domain}> ${domain}s = ${domain}Mapper.selectByExample(example);
        // 获取查询详情
        PageInfo<${Domain}> pageInfo = new PageInfo<>(${domain}s);

        List<${Domain}QueryResp> list = BeanUtil.copyToList(${domain}s, ${Domain}QueryResp.class);

        PageResp<${Domain}QueryResp> pageResp = new PageResp<>();
        pageResp.setTotal(pageInfo.getTotal());
        pageResp.setList(list);
        return pageResp;

    }
}
