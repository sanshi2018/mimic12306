package com.jiawa.train.common.util;

import cn.hutool.core.util.IdUtil;

public class SnowUtil {
    private static long dataCenterID = 1L; // 数据中心

    private static long workerId = 1L; // 机器标识

    public static long getId() {
        return IdUtil.getSnowflake(dataCenterID, workerId).nextId();
    }

    public static String getSnowflakeNextIdStr() {
        return String.valueOf(IdUtil.getSnowflake(dataCenterID, workerId).nextId());
    }
}
