package com.jiawa.train.common.context;

import com.jiawa.train.common.resp.MemberLoginResp;
import lombok.extern.slf4j.Slf4j;

/**
 * 线程上下文类，存储登录会员信息
 * 每个request请求都会创建一个线程，线程上下文类可以在同一个线程中共享数据
 */
@Slf4j
public class LoginMemberContext {

    private static ThreadLocal<MemberLoginResp> member = new ThreadLocal<>();

    public static MemberLoginResp getMember() {
        return member.get();
    }

    public static void setMember(MemberLoginResp member) {
        LoginMemberContext.member.set(member);
    }

    public static void clearMember() {
        LoginMemberContext.member.remove();
    }

    public static Long getId() {
        try {
            return member.get().getId();
        } catch (Exception e) {
            log.error("获取登录会员信息异常", e);
            throw e;
        }
    }

}
