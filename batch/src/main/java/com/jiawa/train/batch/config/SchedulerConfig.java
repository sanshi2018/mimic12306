package com.jiawa.train.batch.config;

import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;

@Component
public class SchedulerConfig {
    @Resource
    private MyJobFactory myJobFactory;

    @Bean
    public SchedulerFactoryBean schedulerFactoryBean(@Qualifier("dataSource")DataSource dataSource) {
        SchedulerFactoryBean factory = new SchedulerFactoryBean();
        factory.setDataSource(dataSource);
        factory.setJobFactory(myJobFactory);
        // 设置程序启动2s后开始定时任务
        factory.setStartupDelay(2);
        return factory;
    }
}
