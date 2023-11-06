package com.jiawa.train.member.service;

import com.jiawa.train.member.mapper.MemberMapper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

    @Resource
    MemberMapper memberMapper;

    public int count() {
        return memberMapper.count();
    }
}
