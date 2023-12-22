package com.jiawa.train.member.req;

import com.jiawa.train.common.req.PageReq;
import lombok.Getter;
import lombok.Setter;

public class PassengerQueryReq extends PageReq {

    @Getter
    @Setter
    private Long memberId;


    @Override
    public String toString() {
        final StringBuffer sb = new StringBuffer("PassengerQueryReq{");
        sb.append("memberId=").append(memberId);
        sb.append('}');
        return sb.toString();
    }
}