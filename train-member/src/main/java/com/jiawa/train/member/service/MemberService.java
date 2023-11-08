package com.jiawa.train.member.service;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.collection.CollectionUtil;
import com.jiawa.train.member.domain.Member;
import com.jiawa.train.member.domain.MemberExample;
import com.jiawa.train.member.mapper.MemberMapper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberService {

    @Resource
    MemberMapper memberMapper;

    public long count() {
        return memberMapper.countByExample(null);
    }

    public long register(String mobile) {
        MemberExample example = new MemberExample();
        example.createCriteria().andMobileEqualTo(mobile);
        List<Member> members = memberMapper.selectByExample(example);
        if (CollUtil.isNotEmpty(members)) {

            throw new RuntimeException("该手机号已注册");
//            throw new Exception("该手机号已注册"); //这样写上层方法需要声明 throws Exception，所以抛出RuntimeException
//            return members.stream().findFirst().get().getId();
        }
        Member member = new Member();
        member.setId(System.currentTimeMillis());
        member.setMobile(mobile);

        memberMapper.insert(member);
        return member.getId();
    }
}
