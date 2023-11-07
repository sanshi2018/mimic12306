package com.jiawa.train.member.controller;

import com.jiawa.train.member.service.MemberService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/member")
public class TestController {
    @Resource
    MemberService memberService;

    @GetMapping("/count")
    public long hello() {
        return memberService.count();
    }
}
