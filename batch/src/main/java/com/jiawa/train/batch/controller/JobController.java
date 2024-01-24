package com.jiawa.train.batch.controller;

import com.jiawa.train.batch.req.CronJobReq;
import com.jiawa.train.batch.resp.CronJobResp;
import com.jiawa.train.common.resp.CommonResp;
import lombok.extern.slf4j.Slf4j;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.Job;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.matchers.GroupMatcher;
import org.quartz.impl.triggers.CronTriggerImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Slf4j
@RestController
@RequestMapping(value = "/admin/job")
public class JobController {

    @Autowired
    private SchedulerFactoryBean schedulerFactoryBean;

    @RequestMapping(value = "/run")
    public CommonResp run(@RequestBody CronJobReq cronJobReq) throws SchedulerException {
        String jobClassName = cronJobReq.getName();
        String jobGroupName = cronJobReq.getGroup();

        log.info("手动执行任务开始: {}, {}", jobClassName, jobGroupName);
        schedulerFactoryBean.getScheduler().triggerJob(JobKey.jobKey(jobClassName, jobGroupName));
        return new CommonResp<>();
    }

    @RequestMapping(value = "/add")
    public CommonResp add(@RequestBody CronJobReq cronJobReq) {
        String jobClassName = cronJobReq.getName();
        String jobGroupName = cronJobReq.getGroup();
        String cronExpression = cronJobReq.getCronExpression();
        String description = cronJobReq.getDescription();

        log.info("创建定时任务: {}, {}, {}, {}", jobClassName, jobGroupName, cronExpression, description);

        CommonResp resp = new CommonResp();
        try {
            // 通过SchedulerFactory获取第一个调度器实例
            Scheduler scheduler = schedulerFactoryBean.getScheduler();

            // 启动调度器
            scheduler.start();

            // 构建job信息
            JobDetail jobDetail = JobBuilder.newJob((Class<? extends Job>) Class.forName(jobClassName))
                    .withIdentity(jobClassName, jobGroupName)
                    .build();

            // 表达式调度构建器（即任务执行时间）
            CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(cronExpression);

            // 按照新的cronExpression表达式构建一个新的Trigger
            CronTrigger trigger = TriggerBuilder.newTrigger()
                    .withIdentity(jobClassName, jobGroupName)
                    .withDescription(description)
                    .withSchedule(cronScheduleBuilder)
                    .build();

            scheduler.scheduleJob(jobDetail, trigger);

        } catch (SchedulerException e) {
            log.error("创建定时任务失败: ", e);
            resp.setSuccess(false);
            resp.setMessage("创建定时任务失败：调度异常");
        } catch (ClassNotFoundException e) {
            log.error("创建定时任务失败:",e);
            resp.setSuccess(false);
            resp.setMessage("创建定时任务失败: 任务类型不存在");
        }
        log.info("创建定时任务结束: {}", resp);
        return resp;
    }

    @RequestMapping("/pause")
    public CommonResp pause(@RequestBody CronJobReq cronJobReq) {
        String jobClassName = cronJobReq.getName();
        String jobGroupName = cronJobReq.getGroup();
        log.info("暂停定时任务：{}, {}", jobClassName, jobGroupName);

        CommonResp resp = new CommonResp();

        try {
            Scheduler scheduler = schedulerFactoryBean.getScheduler();
            scheduler.pauseJob(JobKey.jobKey(jobClassName, jobGroupName));
        } catch (SchedulerException e) {
            log.error("暂停定时任务失败！", e);
            resp.setSuccess(false);
            resp.setMessage("暂停定时任务失败！调度异常");
        }
        log.info("暂停定时任务结束： {}", resp);
        return resp;
    }

    @RequestMapping("/resume")
    public CommonResp resume(@RequestBody CronJobReq cronJobReq) {
        String jobClassName = cronJobReq.getName();
        String jobGroupName = cronJobReq.getGroup();

        log.info("重启定时任务: {}, {}", jobClassName, jobGroupName);
        CommonResp resp = new CommonResp();

        try {
            Scheduler scheduler = schedulerFactoryBean.getScheduler();
            scheduler.resumeJob(JobKey.jobKey(jobClassName, jobGroupName));
        } catch (SchedulerException e) {
            log.error("重启定时任务失败！", e);
            resp.setSuccess(false);
            resp.setMessage("重启定时任务失败！调度异常");
        }

        log.info("重启定时任务结束: {}", resp);
        return resp;
    }

    @RequestMapping(value = "/reschedule")
    public CommonResp reSchedule(@RequestBody CronJobReq cronJobReq) {
        String jobClassName = cronJobReq.getName();
        String jobGroupName = cronJobReq.getGroup();
        String cronExpression = cronJobReq.getCronExpression();
        String description = cronJobReq.getDescription();
        log.info("更新定时任务: {}, {}, {}, {}", jobClassName, jobGroupName, cronExpression, description);

        CommonResp resp = new CommonResp();
        try {
            Scheduler scheduler = schedulerFactoryBean.getScheduler();
            TriggerKey triggerKey = TriggerKey.triggerKey(jobClassName, jobGroupName);
            // 表达式调度构建器
            CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(cronExpression);

            CronTriggerImpl trigger = (CronTriggerImpl) scheduler.getTrigger(triggerKey);
            // 重新设置开始时间
            trigger.setStartTime(new Date());

            CronTrigger trigger1 = trigger;

            // 按新的cronExpression表达式重新构建Trigger
            trigger1 = trigger1.getTriggerBuilder()
                    .withIdentity(triggerKey)
                    .withDescription(description)
                    .withSchedule(scheduleBuilder)
                    .build();

            // 按新的trigger重新设置job执行
            scheduler.rescheduleJob(triggerKey, trigger1);

        } catch (Exception e) {
            log.info("更新定时任务失败！", e);
            resp.setSuccess(false);
            resp.setMessage("更新定时任务失败:调度异常");
        }

        log.info("更新定时任务结束: {}", resp);
        return resp;
    }

    @RequestMapping(value = "/delete")
    public CommonResp delete(@RequestBody CronJobReq cronJobReq) {
        String jobClassName = cronJobReq.getName();
        String jobGroupName = cronJobReq.getGroup();
        log.info("删除定时任务: {}, {}", jobClassName, jobGroupName);

        CommonResp resp = new CommonResp();

        try {
            Scheduler scheduler = schedulerFactoryBean.getScheduler();
            scheduler.pauseTrigger(TriggerKey.triggerKey(jobClassName, jobGroupName));
            scheduler.unscheduleJob(TriggerKey.triggerKey(jobClassName, jobGroupName));
            scheduler.deleteJob(JobKey.jobKey(jobClassName, jobGroupName));
        } catch (SchedulerException e) {
            log.error("删除定时任务失败:", e);
            resp.setSuccess(false);
            resp.setMessage("删除定时任务失败：调度异常");
        }

        log.info("删除定时任务结束: {}", resp);
        return resp;
    }

    @RequestMapping(value = "/query")
    public CommonResp query() {
        log.info("查询所有定时任务");
        CommonResp resp = new CommonResp();

        List<CronJobResp> cronJobResps = new ArrayList<>();
        try {
            Scheduler scheduler = schedulerFactoryBean.getScheduler();
            for (String groupName : scheduler.getJobGroupNames()) {
                for (JobKey jobKey : scheduler.getJobKeys(GroupMatcher.jobGroupEquals(groupName))) {
                    CronJobResp cronJobResp = new CronJobResp();
                    cronJobResp.setName(jobKey.getName());
                    cronJobResp.setGroup(jobKey.getGroup());

                    // get job's trigger
                    List<Trigger> triggers = (List<Trigger>) scheduler.getTriggersOfJob(jobKey);
                    CronTrigger cronTrigger = (CronTrigger) triggers.get(0);

                    cronJobResp.setNextFireTime(cronTrigger.getNextFireTime());
                    cronJobResp.setPreFireTime(cronTrigger.getPreviousFireTime());
                    cronJobResp.setCronExpression(cronTrigger.getCronExpression());
                    cronJobResp.setDescription(cronTrigger.getDescription());

                    Trigger.TriggerState triggerState = scheduler.getTriggerState(cronTrigger.getKey());

                    cronJobResp.setState(triggerState.name());

                    cronJobResps.add(cronJobResp);
                }
            }
        } catch (SchedulerException e) {
            log.info("查看定时任务失败！", e);
            resp.setSuccess(false);
            resp.setMessage("查看定时任务失败:调度异常");
        }

        resp.setContent(cronJobResps);
        log.info("查看定时任务结束", resp);
        return resp;
    }
}
