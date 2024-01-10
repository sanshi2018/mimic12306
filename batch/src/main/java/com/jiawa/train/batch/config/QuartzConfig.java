//package com.jiawa.train.batch.config;
//
//import com.jiawa.train.batch.job.TestJob;
//import org.quartz.CronScheduleBuilder;
//import org.quartz.JobBuilder;
//import org.quartz.JobDetail;
//import org.quartz.Trigger;
//import org.quartz.TriggerBuilder;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//
//@Configuration
//public class QuartzConfig {
//    /**
//     * 声明一个任务
//     */
//    @Bean
//    public JobDetail jobDetail() {
//        return JobBuilder.newJob(TestJob.class)
//                .withIdentity("TestJob", "test")
//                .storeDurably()
//                .build();
//    }
//
//    /**
//     * 声明一个触发器，什么时候触发这个任务
//     */
//    @Bean
//    public Trigger trigger() {
//        return TriggerBuilder.newTrigger()
//                .forJob(jobDetail())
//                .withIdentity("Trigger", "Trigger")
//                .startNow()
//                .withSchedule(CronScheduleBuilder.cronSchedule("*/2 * * * * ?"))
//                .build();
//    }
//}
