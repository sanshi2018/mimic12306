package com.jiawa.train.member.req;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class MemberRegisterReq {

//    @Pattern(regexp = "^1\\\\d{10}$", message = "手机号格式不正确")
    @NotBlank(message = "手机号不能为空")
    private String mobile;

//    @NotBlank(message = "验证码不能为空")
    private String code;

    @Override
    public String toString() {
        return "MemberRegisterReq{" +
                "mobile='" + mobile + '\'' +
                '}';
    }
}
