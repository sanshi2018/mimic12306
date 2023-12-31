package com.jiawa.train.member.controller;

import com.jiawa.train.common.resp.CommonResp;
import com.jiawa.train.member.req.MemberRegisterReq;
import com.jiawa.train.common.resp.MemberLoginResp;
import com.jiawa.train.member.service.MemberService;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/member")
//@CrossOrigin(origins = "*")
public class MemberController {
    @Resource
    MemberService memberService;

    @GetMapping("/count")
    public CommonResp<Long> hello() {
        return new CommonResp<>(memberService.count());
    }

    @PostMapping("/register")
    public CommonResp<Long> register(@Valid @RequestBody MemberRegisterReq req) {
        return new CommonResp<>(memberService.register(req));
    }

    @PostMapping("/send-code")
    public CommonResp<String> sendCode(@Valid @RequestBody MemberRegisterReq req) {
        return new CommonResp<>(memberService.sendCode(req));
    }

    @PostMapping("/login")
    public CommonResp<MemberLoginResp>login(@Valid @RequestBody MemberRegisterReq req) {
        return new CommonResp<>(memberService.login(req));
    }
}
