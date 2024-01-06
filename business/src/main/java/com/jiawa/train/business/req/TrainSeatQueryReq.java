package com.jiawa.train.business.req;

import com.jiawa.train.common.req.PageReq;
import lombok.Getter;
import lombok.Setter;

public class TrainSeatQueryReq extends PageReq {

    @Getter
    @Setter
    private String trainCode;

    @Override
    public String toString() {
        return "TrainSeatQueryReq{" +
                "trainCode='" + trainCode + '\'' +
                "} " + super.toString();
    }
}