package com.jiawa.train.business.req;

import com.jiawa.train.common.req.PageReq;
import lombok.Getter;
import lombok.Setter;

public class DailyTrainSeatQueryReq extends PageReq {
    @Getter
    @Setter
    private String trainCode;

    @Override
    public String toString() {
        return "DailyTrainSeatQueryReq{" +
                "trainCode='" + trainCode + '\'' +
                "} " + super.toString();
    }
}