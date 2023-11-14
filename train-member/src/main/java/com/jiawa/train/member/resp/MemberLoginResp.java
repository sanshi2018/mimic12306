package com.jiawa.train.member.resp;

import lombok.Data;

@Data
public class MemberLoginResp {
    private long id;
    private String mobile;
    private String token;
}
