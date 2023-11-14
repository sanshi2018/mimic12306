package com.jiawa.train.member.service;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.jwt.JWTUtil;
import com.jiawa.train.common.exception.BusinessException;
import com.jiawa.train.common.exception.EBusinessException;
import com.jiawa.train.common.resp.CommonResp;
import com.jiawa.train.common.util.JwtUtil;
import com.jiawa.train.common.util.SnowUtil;
import com.jiawa.train.member.domain.Member;
import com.jiawa.train.member.domain.MemberExample;
import com.jiawa.train.member.mapper.MemberMapper;
import com.jiawa.train.member.req.MemberRegisterReq;
import com.jiawa.train.member.resp.MemberLoginResp;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

@Slf4j
@Service
public class MemberService {

    @Resource
    MemberMapper memberMapper;

    public long count() {
        return memberMapper.countByExample(null);
    }

    public long register(MemberRegisterReq req) {
        String mobile = req.getMobile();
        var me = getMembersByMobile(mobile);
        if (!Objects.isNull(me)) {
            throw new BusinessException(EBusinessException.MEMBER_MOBILE_EXIST);
//            throw new RuntimeException("该手机号已注册");
//            throw new Exception("该手机号已注册"); //这样写上层方法需要声明 throws Exception，所以抛出RuntimeException
//            return members.stream().findFirst().get().getId();
        }
        Member member = new Member();
        member.setId(SnowUtil.getId());
        member.setMobile(mobile);

        memberMapper.insert(member);
        return member.getId();
    }

    public String sendCode(MemberRegisterReq req) {
        String mobile = req.getMobile();
        var me = getMembersByMobile(mobile);
        if (Objects.isNull(me)) {
            log.info("手机号：{},不存在,插入新数据", mobile);
            Member member = new Member();
            member.setId(SnowUtil.getId());
            member.setMobile(mobile);
            memberMapper.insert(member);
        } else {
            log.info("手机号：{},已存在,更新数据", mobile);
        }

        // 生成验证码
//        String code = IdUtil.simpleUUID().substring(0, 6);

        String code = "8888";
        log.info("手机号：{}，验证码：{}", mobile, code);

        log.info("保存短信记录");
        log.info("调用短信服务发送验证码");

        return code;
    }

    public MemberLoginResp login(MemberRegisterReq req) {
        String mobile = req.getMobile();
        String code = req.getCode();
        var memberDB = getMembersByMobile(mobile);
        // 如果这个手机号没有发送过验证码，需要报错
        if (Objects.isNull(memberDB)) {
            throw new BusinessException(EBusinessException.MEMBER_MOBILE_NOT_EXIST);
        }
        // 校验验证码
        if (!Objects.equals(code, "8888")) {
            throw new BusinessException(EBusinessException.MEMBER_CODE_ERROR);
        }
        MemberLoginResp resp = new MemberLoginResp();
        BeanUtils.copyProperties(memberDB, resp);
        String token = JwtUtil.createToken(resp.getId(), resp.getMobile());
        resp.setToken(token);
        return resp;
//        return new CommonResp<MemberLoginResp>().success(resp);
    }

    private Member getMembersByMobile(String mobile) {
        MemberExample example = new MemberExample();
        example.createCriteria().andMobileEqualTo(mobile);
        List<Member> members = memberMapper.selectByExample(example);
        if (CollectionUtil.isEmpty(members)) {
            return null;
        }
        return members.get(0);
    }
}
