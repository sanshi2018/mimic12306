package com.jiawa.train.batch.job;

import cn.hutool.core.util.RandomUtil;
import lombok.extern.slf4j.Slf4j;
import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.slf4j.MDC;

@Slf4j
@DisallowConcurrentExecution
public class DailyTrainJob implements Job {
    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        MDC.put("LOG_ID", System.currentTimeMillis() + RandomUtil.randomString(3));
        log.info("生成每日车次数据库开始");
        log.info("生成每日车次数据库结束");
    }
}
