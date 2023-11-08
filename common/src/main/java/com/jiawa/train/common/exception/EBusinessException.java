package com.jiawa.train.common.exception;

import lombok.Getter;

@Getter
public enum EBusinessException {
    MEMBER_MOBILE_EXIST("手机号已存在")
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
