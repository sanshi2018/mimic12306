package com.jiawa.train.common.exception;

import lombok.Getter;

@Getter
public enum EBusinessException {
    MEMBER_MOBILE_EXIST("手机号已存在"),
    MEMBER_MOBILE_NOT_EXIST("请先获取验证码"),
    MEMBER_CODE_ERROR("验证码错误"),
    ;
    private final String desc;

    EBusinessException(String desc) {
        this.desc = desc;
    }

    @Override
    public String toString() {
        return "EBusinessException{" +
                "message='" + desc + '\'' +
                '}';
    }
}
