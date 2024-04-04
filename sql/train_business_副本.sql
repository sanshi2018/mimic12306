/*
 Navicat Premium Data Transfer

 Source Server         : win_mysql
 Source Server Type    : MySQL
 Source Server Version : 50744
 Source Host           : 192.168.50.193:3306
 Source Schema         : train_business

 Target Server Type    : MySQL
 Target Server Version : 50744
 File Encoding         : 65001

 Date: 04/04/2024 23:49:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `BLOB_DATA` blob COMMENT '数据',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `CALENDAR_NAME` varchar(200) NOT NULL COMMENT '日程名称',
  `CALENDAR` blob NOT NULL COMMENT '日程数据',
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `CRON_EXPRESSION` varchar(200) NOT NULL COMMENT 'cron表达式',
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------
BEGIN;
INSERT INTO `QRTZ_CRON_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `CRON_EXPRESSION`, `TIME_ZONE_ID`) VALUES ('schedulerFactoryBean', 'com.jiawa.train.batch.job.DailyTrainJob', 'DEFAULT', '0/5 * * * * ?', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `CRON_EXPRESSION`, `TIME_ZONE_ID`) VALUES ('schedulerFactoryBean', 'com.jiawa.train.batch.job.TestJob', 'DEFAULT', '1/5 * * * * ?', 'Asia/Shanghai');
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `ENTRY_ID` varchar(95) NOT NULL COMMENT 'entryId',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `INSTANCE_NAME` varchar(200) NOT NULL COMMENT '实例名称',
  `FIRED_TIME` bigint(13) NOT NULL COMMENT '执行时间',
  `SCHED_TIME` bigint(13) NOT NULL COMMENT '定时任务时间',
  `PRIORITY` int(11) NOT NULL COMMENT '等级',
  `STATE` varchar(16) NOT NULL COMMENT '状态',
  `JOB_NAME` varchar(200) DEFAULT NULL COMMENT 'job名称',
  `JOB_GROUP` varchar(200) DEFAULT NULL COMMENT 'job组',
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL COMMENT '是否异步',
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL COMMENT '是否请求覆盖',
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `JOB_NAME` varchar(200) NOT NULL COMMENT 'job名称',
  `JOB_GROUP` varchar(200) NOT NULL COMMENT 'job组',
  `DESCRIPTION` varchar(250) DEFAULT NULL COMMENT '描述',
  `JOB_CLASS_NAME` varchar(250) NOT NULL COMMENT 'job类名',
  `IS_DURABLE` varchar(1) NOT NULL COMMENT '是否持久化',
  `IS_NONCONCURRENT` varchar(1) NOT NULL COMMENT '是否非同步',
  `IS_UPDATE_DATA` varchar(1) NOT NULL COMMENT '是否更新数据',
  `REQUESTS_RECOVERY` varchar(1) NOT NULL COMMENT '请求是否覆盖',
  `JOB_DATA` blob COMMENT 'job数据',
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------
BEGIN;
INSERT INTO `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`, `DESCRIPTION`, `JOB_CLASS_NAME`, `IS_DURABLE`, `IS_NONCONCURRENT`, `IS_UPDATE_DATA`, `REQUESTS_RECOVERY`, `JOB_DATA`) VALUES ('schedulerFactoryBean', 'com.jiawa.train.batch.job.DailyTrainJob', 'DEFAULT', NULL, 'com.jiawa.train.batch.job.DailyTrainJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787000737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F40000000000010770800000010000000007800);
INSERT INTO `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`, `DESCRIPTION`, `JOB_CLASS_NAME`, `IS_DURABLE`, `IS_NONCONCURRENT`, `IS_UPDATE_DATA`, `REQUESTS_RECOVERY`, `JOB_DATA`) VALUES ('schedulerFactoryBean', 'com.jiawa.train.batch.job.TestJob', 'DEFAULT', NULL, 'com.jiawa.train.batch.job.TestJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787000737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F40000000000010770800000010000000007800);
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `LOCK_NAME` varchar(40) NOT NULL COMMENT 'lock名称',
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------
BEGIN;
INSERT INTO `QRTZ_LOCKS` (`SCHED_NAME`, `LOCK_NAME`) VALUES ('schedulerFactoryBean', 'TRIGGER_ACCESS');
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `INSTANCE_NAME` varchar(200) NOT NULL COMMENT '实例名称',
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL COMMENT '最近检入时间',
  `CHECKIN_INTERVAL` bigint(13) NOT NULL COMMENT '检入间隔',
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `REPEAT_COUNT` bigint(7) NOT NULL COMMENT '重复执行次数',
  `REPEAT_INTERVAL` bigint(12) NOT NULL COMMENT '重复执行间隔',
  `TIMES_TRIGGERED` bigint(10) NOT NULL COMMENT '已经触发次数',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `STR_PROP_1` varchar(512) DEFAULT NULL COMMENT '开始配置1',
  `STR_PROP_2` varchar(512) DEFAULT NULL COMMENT '开始配置2',
  `STR_PROP_3` varchar(512) DEFAULT NULL COMMENT '开始配置3',
  `INT_PROP_1` int(11) DEFAULT NULL COMMENT 'int配置1',
  `INT_PROP_2` int(11) DEFAULT NULL COMMENT 'int配置2',
  `LONG_PROP_1` bigint(20) DEFAULT NULL COMMENT 'long配置1',
  `LONG_PROP_2` bigint(20) DEFAULT NULL COMMENT 'long配置2',
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL COMMENT '配置描述1',
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL COMMENT '配置描述2',
  `BOOL_PROP_1` varchar(1) DEFAULT NULL COMMENT 'bool配置1',
  `BOOL_PROP_2` varchar(1) DEFAULT NULL COMMENT 'bool配置2',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL COMMENT '定时任务名称',
  `TRIGGER_NAME` varchar(200) NOT NULL COMMENT '触发器名称',
  `TRIGGER_GROUP` varchar(200) NOT NULL COMMENT '触发器组',
  `JOB_NAME` varchar(200) NOT NULL COMMENT 'job名称',
  `JOB_GROUP` varchar(200) NOT NULL COMMENT 'job组',
  `DESCRIPTION` varchar(250) DEFAULT NULL COMMENT '描述',
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL COMMENT '下一次触发时间',
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL COMMENT '前一次触发时间',
  `PRIORITY` int(11) DEFAULT NULL COMMENT '等级',
  `TRIGGER_STATE` varchar(16) NOT NULL COMMENT '触发状态',
  `TRIGGER_TYPE` varchar(8) NOT NULL COMMENT '触发类型',
  `START_TIME` bigint(13) NOT NULL COMMENT '开始时间',
  `END_TIME` bigint(13) DEFAULT NULL COMMENT '结束时间',
  `CALENDAR_NAME` varchar(200) DEFAULT NULL COMMENT '日程名称',
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL COMMENT '未触发实例',
  `JOB_DATA` blob COMMENT 'job数据',
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------
BEGIN;
INSERT INTO `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `JOB_NAME`, `JOB_GROUP`, `DESCRIPTION`, `NEXT_FIRE_TIME`, `PREV_FIRE_TIME`, `PRIORITY`, `TRIGGER_STATE`, `TRIGGER_TYPE`, `START_TIME`, `END_TIME`, `CALENDAR_NAME`, `MISFIRE_INSTR`, `JOB_DATA`) VALUES ('schedulerFactoryBean', 'com.jiawa.train.batch.job.DailyTrainJob', 'DEFAULT', 'com.jiawa.train.batch.job.DailyTrainJob', 'DEFAULT', '生成每日车次', 1706026615000, 1706026610000, 5, 'PAUSED', 'CRON', 1706026583000, 0, NULL, 0, '');
INSERT INTO `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `JOB_NAME`, `JOB_GROUP`, `DESCRIPTION`, `NEXT_FIRE_TIME`, `PREV_FIRE_TIME`, `PRIORITY`, `TRIGGER_STATE`, `TRIGGER_TYPE`, `START_TIME`, `END_TIME`, `CALENDAR_NAME`, `MISFIRE_INSTR`, `JOB_DATA`) VALUES ('schedulerFactoryBean', 'com.jiawa.train.batch.job.TestJob', 'DEFAULT', 'com.jiawa.train.batch.job.TestJob', 'DEFAULT', '刨皮测试', 1706026611000, 1706026606000, 5, 'PAUSED', 'CRON', 1706026586000, 0, NULL, 0, '');
COMMIT;

-- ----------------------------
-- Table structure for daily_train
-- ----------------------------
DROP TABLE IF EXISTS `daily_train`;
CREATE TABLE `daily_train` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `date` date NOT NULL COMMENT '日期',
  `code` varchar(20) NOT NULL COMMENT '车次编号',
  `type` char(1) NOT NULL COMMENT '车次类型|枚举[TrainTypeEnum]',
  `start` varchar(20) NOT NULL COMMENT '始发站',
  `start_pinyin` varchar(50) NOT NULL COMMENT '始发站拼音',
  `start_time` time NOT NULL COMMENT '出发时间',
  `end` varchar(20) NOT NULL COMMENT '终点站',
  `end_pinyin` varchar(50) NOT NULL COMMENT '终点站拼音',
  `end_time` time NOT NULL COMMENT '到站时间',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `date_code_unique` (`date`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='每日车次';

-- ----------------------------
-- Records of daily_train
-- ----------------------------
BEGIN;
INSERT INTO `daily_train` (`id`, `date`, `code`, `type`, `start`, `start_pinyin`, `start_time`, `end`, `end_pinyin`, `end_time`, `create_time`, `update_time`) VALUES (1750544700718321664, '2024-01-25', '1151', 'G', '北京南', 'beijingnan', '10:00:00', '上海-虹桥', 'shanghai-hongqiao', '14:00:00', '2024-01-25 23:42:34.856', '2024-01-25 23:42:34.856');
INSERT INTO `daily_train` (`id`, `date`, `code`, `type`, `start`, `start_pinyin`, `start_time`, `end`, `end_pinyin`, `end_time`, `create_time`, `update_time`) VALUES (1750544763733544960, '2024-01-25', '1211', 'G', 'bj', 'bj', '00:00:00', 'sh', 'sh', '00:00:02', '2024-01-25 23:42:49.880', '2024-01-25 23:42:49.880');
INSERT INTO `daily_train` (`id`, `date`, `code`, `type`, `start`, `start_pinyin`, `start_time`, `end`, `end_pinyin`, `end_time`, `create_time`, `update_time`) VALUES (1750553297061810176, '2024-01-26', '1151', 'G', '北京南', 'beijingnan', '10:00:00', '上海-虹桥', 'shanghai-hongqiao', '14:00:00', '2024-01-26 00:16:43.520', '2024-01-26 00:16:43.520');
INSERT INTO `daily_train` (`id`, `date`, `code`, `type`, `start`, `start_pinyin`, `start_time`, `end`, `end_pinyin`, `end_time`, `create_time`, `update_time`) VALUES (1750553406331817984, '2024-01-26', '1211', 'G', '北京南', 'beijingnan', '17:00:00', '苏州', 'suzhou', '20:00:00', '2024-01-26 00:17:09.484', '2024-01-26 00:17:09.484');
INSERT INTO `daily_train` (`id`, `date`, `code`, `type`, `start`, `start_pinyin`, `start_time`, `end`, `end_pinyin`, `end_time`, `create_time`, `update_time`) VALUES (1750915824404795392, '2024-01-27', '1151', 'G', '北京南', 'beijingnan', '10:00:00', '上海-虹桥', 'shanghai-hongqiao', '14:00:00', '2024-01-27 00:17:17.634', '2024-01-27 00:17:17.634');
INSERT INTO `daily_train` (`id`, `date`, `code`, `type`, `start`, `start_pinyin`, `start_time`, `end`, `end_pinyin`, `end_time`, `create_time`, `update_time`) VALUES (1750915827802181632, '2024-01-27', '1211', 'G', '北京南', 'beijingnan', '17:00:00', '苏州', 'suzhou', '20:00:00', '2024-01-27 00:17:18.448', '2024-01-27 00:17:18.448');
INSERT INTO `daily_train` (`id`, `date`, `code`, `type`, `start`, `start_pinyin`, `start_time`, `end`, `end_pinyin`, `end_time`, `create_time`, `update_time`) VALUES (1750917317417635840, '2024-01-28', '1151', 'G', '北京南', 'beijingnan', '10:00:00', '上海-虹桥', 'shanghai-hongqiao', '14:00:00', '2024-01-27 00:23:13.600', '2024-01-27 00:23:13.600');
INSERT INTO `daily_train` (`id`, `date`, `code`, `type`, `start`, `start_pinyin`, `start_time`, `end`, `end_pinyin`, `end_time`, `create_time`, `update_time`) VALUES (1750917320148127744, '2024-01-28', '1211', 'G', '北京南', 'beijingnan', '17:00:00', '苏州', 'suzhou', '20:00:00', '2024-01-27 00:23:14.251', '2024-01-27 00:23:14.251');
INSERT INTO `daily_train` (`id`, `date`, `code`, `type`, `start`, `start_pinyin`, `start_time`, `end`, `end_pinyin`, `end_time`, `create_time`, `update_time`) VALUES (1753742641721380864, '2024-02-03', '1151', 'G', '北京南', 'beijingnan', '10:00:00', '上海-虹桥', 'shanghai-hongqiao', '14:00:00', '2024-02-03 19:30:03.406', '2024-02-03 19:30:03.406');
INSERT INTO `daily_train` (`id`, `date`, `code`, `type`, `start`, `start_pinyin`, `start_time`, `end`, `end_pinyin`, `end_time`, `create_time`, `update_time`) VALUES (1753742662248304640, '2024-02-03', '1211', 'G', '北京南', 'beijingnan', '17:00:00', '苏州', 'suzhou', '20:00:00', '2024-02-03 19:30:08.299', '2024-02-03 19:30:08.299');
COMMIT;

-- ----------------------------
-- Table structure for daily_train_carriage
-- ----------------------------
DROP TABLE IF EXISTS `daily_train_carriage`;
CREATE TABLE `daily_train_carriage` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `date` date NOT NULL COMMENT '日期',
  `train_code` varchar(20) NOT NULL COMMENT '车次编号',
  `index` int(11) NOT NULL COMMENT '箱序',
  `seat_type` char(1) NOT NULL COMMENT '座位类型|枚举[SeatTypeEnum]',
  `seat_count` int(11) NOT NULL COMMENT '座位数',
  `row_count` int(11) NOT NULL COMMENT '排数',
  `col_count` int(11) NOT NULL COMMENT '列数',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `date_train_code_index_unique` (`date`,`train_code`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='每日车箱';

-- ----------------------------
-- Records of daily_train_carriage
-- ----------------------------
BEGIN;
INSERT INTO `daily_train_carriage` (`id`, `date`, `train_code`, `index`, `seat_type`, `seat_count`, `row_count`, `col_count`, `create_time`, `update_time`) VALUES (1750915824723562496, '2024-01-27', '1151', 1, '1', 10, 5, 2, '2024-01-27 00:17:17.714', '2024-01-27 00:17:17.714');
INSERT INTO `daily_train_carriage` (`id`, `date`, `train_code`, `index`, `seat_type`, `seat_count`, `row_count`, `col_count`, `create_time`, `update_time`) VALUES (1750917317849649152, '2024-01-28', '1151', 1, '1', 10, 5, 2, '2024-01-27 00:23:13.703', '2024-01-27 00:23:13.703');
INSERT INTO `daily_train_carriage` (`id`, `date`, `train_code`, `index`, `seat_type`, `seat_count`, `row_count`, `col_count`, `create_time`, `update_time`) VALUES (1753742643378130944, '2024-02-03', '1151', 1, '1', 10, 5, 2, '2024-02-03 19:30:03.800', '2024-02-03 19:30:03.800');
COMMIT;

-- ----------------------------
-- Table structure for daily_train_seat
-- ----------------------------
DROP TABLE IF EXISTS `daily_train_seat`;
CREATE TABLE `daily_train_seat` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `date` date NOT NULL COMMENT '日期',
  `train_code` varchar(20) NOT NULL COMMENT '车次编号',
  `carriage_index` int(11) NOT NULL COMMENT '箱序',
  `row` char(2) NOT NULL COMMENT '排号|01, 02',
  `col` char(1) NOT NULL COMMENT '列号|枚举[SeatColEnum]',
  `seat_type` char(1) NOT NULL COMMENT '座位类型|枚举[SeatTypeEnum]',
  `carriage_seat_index` int(11) NOT NULL COMMENT '同车箱座序',
  `sell` varchar(50) NOT NULL COMMENT '售卖情况|将经过的车站用01拼接，0表示可卖，1表示已卖',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='每日座位';

-- ----------------------------
-- Records of daily_train_seat
-- ----------------------------
BEGIN;
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915825042329600, '2024-01-27', '1151', 1, '01', 'A', '1', 1, '0000000000000000000', '2024-01-27 00:17:17.789', '2024-01-27 00:17:17.789');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915825088466944, '2024-01-27', '1151', 1, '01', 'C', '1', 2, '0000000000000000000', '2024-01-27 00:17:17.801', '2024-01-27 00:17:17.801');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915825805692928, '2024-01-27', '1151', 1, '01', 'D', '1', 3, '0000000000000000000', '2024-01-27 00:17:17.971', '2024-01-27 00:17:17.971');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915825876996096, '2024-01-27', '1151', 1, '01', 'F', '1', 4, '0000000000000000000', '2024-01-27 00:17:17.988', '2024-01-27 00:17:17.988');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915825931522048, '2024-01-27', '1151', 1, '02', 'A', '1', 5, '0000000000000000000', '2024-01-27 00:17:18.001', '2024-01-27 00:17:18.001');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915825990242304, '2024-01-27', '1151', 1, '02', 'C', '1', 6, '0000000000000000000', '2024-01-27 00:17:18.015', '2024-01-27 00:17:18.015');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915826044768256, '2024-01-27', '1151', 1, '02', 'D', '1', 7, '0000000000000000000', '2024-01-27 00:17:18.028', '2024-01-27 00:17:18.028');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915826107682816, '2024-01-27', '1151', 1, '02', 'F', '1', 8, '0000000000000000000', '2024-01-27 00:17:18.044', '2024-01-27 00:17:18.044');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915826279649280, '2024-01-27', '1151', 1, '03', 'A', '1', 9, '0000000000000000000', '2024-01-27 00:17:18.085', '2024-01-27 00:17:18.085');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915826392895488, '2024-01-27', '1151', 1, '03', 'C', '1', 10, '0000000000000000000', '2024-01-27 00:17:18.112', '2024-01-27 00:17:18.112');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915826439032832, '2024-01-27', '1151', 1, '03', 'D', '1', 11, '0000000000000000000', '2024-01-27 00:17:18.123', '2024-01-27 00:17:18.123');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915826489364480, '2024-01-27', '1151', 1, '03', 'F', '1', 12, '0000000000000000000', '2024-01-27 00:17:18.135', '2024-01-27 00:17:18.135');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915826543890432, '2024-01-27', '1151', 1, '04', 'A', '1', 13, '0000000000000000000', '2024-01-27 00:17:18.148', '2024-01-27 00:17:18.148');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915826606804992, '2024-01-27', '1151', 1, '04', 'C', '1', 14, '0000000000000000000', '2024-01-27 00:17:18.162', '2024-01-27 00:17:18.162');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915826766188544, '2024-01-27', '1151', 1, '04', 'D', '1', 15, '0000000000000000000', '2024-01-27 00:17:18.200', '2024-01-27 00:17:18.200');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915826866851840, '2024-01-27', '1151', 1, '04', 'F', '1', 16, '0000000000000000000', '2024-01-27 00:17:18.220', '2024-01-27 00:17:18.220');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915826938155008, '2024-01-27', '1151', 1, '05', 'A', '1', 17, '0000000000000000000', '2024-01-27 00:17:18.241', '2024-01-27 00:17:18.241');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915826996875264, '2024-01-27', '1151', 1, '05', 'C', '1', 18, '0000000000000000000', '2024-01-27 00:17:18.255', '2024-01-27 00:17:18.255');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915827437277184, '2024-01-27', '1151', 1, '05', 'D', '1', 19, '0000000000000000000', '2024-01-27 00:17:18.359', '2024-01-27 00:17:18.359');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750915827508580352, '2024-01-27', '1151', 1, '05', 'F', '1', 20, '0000000000000000000', '2024-01-27 00:17:18.377', '2024-01-27 00:17:18.377');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917318336188416, '2024-01-28', '1151', 1, '01', 'A', '1', 1, '0000000000000000000', '2024-01-27 00:23:13.819', '2024-01-27 00:23:13.819');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917318386520064, '2024-01-28', '1151', 1, '01', 'C', '1', 2, '0000000000000000000', '2024-01-27 00:23:13.831', '2024-01-27 00:23:13.831');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917318554292224, '2024-01-28', '1151', 1, '01', 'D', '1', 3, '0000000000000000000', '2024-01-27 00:23:13.871', '2024-01-27 00:23:13.871');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917318600429568, '2024-01-28', '1151', 1, '01', 'F', '1', 4, '0000000000000000000', '2024-01-27 00:23:13.882', '2024-01-27 00:23:13.882');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917318663344128, '2024-01-28', '1151', 1, '02', 'A', '1', 5, '0000000000000000000', '2024-01-27 00:23:13.897', '2024-01-27 00:23:13.897');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917318713675776, '2024-01-28', '1151', 1, '02', 'C', '1', 6, '0000000000000000000', '2024-01-27 00:23:13.909', '2024-01-27 00:23:13.909');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917318772396032, '2024-01-28', '1151', 1, '02', 'D', '1', 7, '0000000000000000000', '2024-01-27 00:23:13.922', '2024-01-27 00:23:13.922');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917318826921984, '2024-01-28', '1151', 1, '02', 'F', '1', 8, '0000000000000000000', '2024-01-27 00:23:13.936', '2024-01-27 00:23:13.936');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917319015665664, '2024-01-28', '1151', 1, '03', 'A', '1', 9, '0000000000000000000', '2024-01-27 00:23:13.980', '2024-01-27 00:23:13.980');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917319099551744, '2024-01-28', '1151', 1, '03', 'C', '1', 10, '0000000000000000000', '2024-01-27 00:23:14.001', '2024-01-27 00:23:14.001');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917319170854912, '2024-01-28', '1151', 1, '03', 'D', '1', 11, '0000000000000000000', '2024-01-27 00:23:14.018', '2024-01-27 00:23:14.018');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917319242158080, '2024-01-28', '1151', 1, '03', 'F', '1', 12, '0000000000000000000', '2024-01-27 00:23:14.035', '2024-01-27 00:23:14.035');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917319305072640, '2024-01-28', '1151', 1, '04', 'A', '1', 13, '0000000000000000000', '2024-01-27 00:23:14.050', '2024-01-27 00:23:14.050');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917319367987200, '2024-01-28', '1151', 1, '04', 'C', '1', 14, '0000000000000000000', '2024-01-27 00:23:14.065', '2024-01-27 00:23:14.065');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917319544147968, '2024-01-28', '1151', 1, '04', 'D', '1', 15, '0000000000000000000', '2024-01-27 00:23:14.106', '2024-01-27 00:23:14.106');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917319594479616, '2024-01-28', '1151', 1, '04', 'F', '1', 16, '0000000000000000000', '2024-01-27 00:23:14.118', '2024-01-27 00:23:14.118');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917319653199872, '2024-01-28', '1151', 1, '05', 'A', '1', 17, '0000000000000000000', '2024-01-27 00:23:14.132', '2024-01-27 00:23:14.132');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917319699337216, '2024-01-28', '1151', 1, '05', 'C', '1', 18, '0000000000000000000', '2024-01-27 00:23:14.144', '2024-01-27 00:23:14.144');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917319762251776, '2024-01-28', '1151', 1, '05', 'D', '1', 19, '0000000000000000000', '2024-01-27 00:23:14.159', '2024-01-27 00:23:14.159');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1750917319955189760, '2024-01-28', '1151', 1, '05', 'F', '1', 20, '0000000000000000000', '2024-01-27 00:23:14.205', '2024-01-27 00:23:14.205');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742644049219584, '2024-02-03', '1151', 1, '01', 'A', '1', 1, '0000000000000000000', '2024-02-03 19:30:03.960', '2024-02-03 19:30:03.960');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742644099551232, '2024-02-03', '1151', 1, '01', 'C', '1', 2, '0000000000000000000', '2024-02-03 19:30:03.973', '2024-02-03 19:30:03.973');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742644149882880, '2024-02-03', '1151', 1, '01', 'D', '1', 3, '0000000000000000000', '2024-02-03 19:30:03.985', '2024-02-03 19:30:03.985');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742644703531008, '2024-02-03', '1151', 1, '01', 'F', '1', 4, '0000000000000000000', '2024-02-03 19:30:04.116', '2024-02-03 19:30:04.116');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742644766445568, '2024-02-03', '1151', 1, '02', 'A', '1', 5, '0000000000000000000', '2024-02-03 19:30:04.132', '2024-02-03 19:30:04.132');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742644825165824, '2024-02-03', '1151', 1, '02', 'C', '1', 6, '0000000000000000000', '2024-02-03 19:30:04.146', '2024-02-03 19:30:04.146');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742645009715200, '2024-02-03', '1151', 1, '02', 'D', '1', 7, '0000000000000000000', '2024-02-03 19:30:04.190', '2024-02-03 19:30:04.190');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742645051658240, '2024-02-03', '1151', 1, '02', 'F', '1', 8, '0000000000000000000', '2024-02-03 19:30:04.200', '2024-02-03 19:30:04.200');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742645265567744, '2024-02-03', '1151', 1, '03', 'A', '1', 9, '0000000000000000000', '2024-02-03 19:30:04.251', '2024-02-03 19:30:04.251');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742645324288000, '2024-02-03', '1151', 1, '03', 'C', '1', 10, '0000000000000000000', '2024-02-03 19:30:04.265', '2024-02-03 19:30:04.265');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742645399785472, '2024-02-03', '1151', 1, '03', 'D', '1', 11, '0000000000000000000', '2024-02-03 19:30:04.282', '2024-02-03 19:30:04.282');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742645496254464, '2024-02-03', '1151', 1, '03', 'F', '1', 12, '0000000000000000000', '2024-02-03 19:30:04.301', '2024-02-03 19:30:04.301');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742645559169024, '2024-02-03', '1151', 1, '04', 'A', '1', 13, '0000000000000000000', '2024-02-03 19:30:04.320', '2024-02-03 19:30:04.320');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742645735329792, '2024-02-03', '1151', 1, '04', 'C', '1', 14, '0000000000000000000', '2024-02-03 19:30:04.363', '2024-02-03 19:30:04.363');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742645785661440, '2024-02-03', '1151', 1, '04', 'D', '1', 15, '0000000000000000000', '2024-02-03 19:30:04.375', '2024-02-03 19:30:04.375');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742645852770304, '2024-02-03', '1151', 1, '04', 'F', '1', 16, '0000000000000000000', '2024-02-03 19:30:04.388', '2024-02-03 19:30:04.388');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742645907296256, '2024-02-03', '1151', 1, '05', 'A', '1', 17, '0000000000000000000', '2024-02-03 19:30:04.404', '2024-02-03 19:30:04.404');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742645949239296, '2024-02-03', '1151', 1, '05', 'C', '1', 18, '0000000000000000000', '2024-02-03 19:30:04.414', '2024-02-03 19:30:04.414');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742645986988032, '2024-02-03', '1151', 1, '05', 'D', '1', 19, '0000000000000000000', '2024-02-03 19:30:04.423', '2024-02-03 19:30:04.423');
INSERT INTO `daily_train_seat` (`id`, `date`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `sell`, `create_time`, `update_time`) VALUES (1753742646062485504, '2024-02-03', '1151', 1, '05', 'F', '1', 20, '0000000000000000000', '2024-02-03 19:30:04.441', '2024-02-03 19:30:04.441');
COMMIT;

-- ----------------------------
-- Table structure for daily_train_station
-- ----------------------------
DROP TABLE IF EXISTS `daily_train_station`;
CREATE TABLE `daily_train_station` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `date` date NOT NULL COMMENT '日期',
  `train_code` varchar(20) NOT NULL COMMENT '车次编号',
  `index` int(11) NOT NULL COMMENT '站序',
  `name` varchar(20) NOT NULL COMMENT '站名',
  `name_pinyin` varchar(50) NOT NULL COMMENT '站名拼音',
  `in_time` time DEFAULT NULL COMMENT '进站时间',
  `out_time` time DEFAULT NULL COMMENT '出站时间',
  `stop_time` time DEFAULT NULL COMMENT '停站时长',
  `km` decimal(8,2) NOT NULL COMMENT '里程（公里）|从上一站到本站的距离',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `date_train_code_index_unique` (`date`,`train_code`,`index`),
  UNIQUE KEY `date_train_code_name_unique` (`date`,`train_code`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='每日车站';

-- ----------------------------
-- Records of daily_train_station
-- ----------------------------
BEGIN;
INSERT INTO `daily_train_station` (`id`, `date`, `train_code`, `index`, `name`, `name_pinyin`, `in_time`, `out_time`, `stop_time`, `km`, `create_time`, `update_time`) VALUES (1750544763532218368, '2024-01-25', '1151', 115, '天津', 'tianjin', '11:00:00', '12:00:00', '01:00:00', 15.00, '2024-01-25 23:42:49.830', '2024-01-25 23:42:49.830');
INSERT INTO `daily_train_station` (`id`, `date`, `train_code`, `index`, `name`, `name_pinyin`, `in_time`, `out_time`, `stop_time`, `km`, `create_time`, `update_time`) VALUES (1750553336421158912, '2024-01-26', '1151', 115, '天津', 'tianjin', '11:00:00', '12:00:00', '01:00:00', 15.00, '2024-01-26 00:16:53.767', '2024-01-26 00:16:53.767');
INSERT INTO `daily_train_station` (`id`, `date`, `train_code`, `index`, `name`, `name_pinyin`, `in_time`, `out_time`, `stop_time`, `km`, `create_time`, `update_time`) VALUES (1750915824551596032, '2024-01-27', '1151', 115, '天津', 'tianjin', '11:00:00', '12:00:00', '01:00:00', 15.00, '2024-01-27 00:17:17.672', '2024-01-27 00:17:17.672');
INSERT INTO `daily_train_station` (`id`, `date`, `train_code`, `index`, `name`, `name_pinyin`, `in_time`, `out_time`, `stop_time`, `km`, `create_time`, `update_time`) VALUES (1750917317694459904, '2024-01-28', '1151', 115, '天津', 'tianjin', '11:00:00', '12:00:00', '01:00:00', 15.00, '2024-01-27 00:23:13.665', '2024-01-27 00:23:13.665');
INSERT INTO `daily_train_station` (`id`, `date`, `train_code`, `index`, `name`, `name_pinyin`, `in_time`, `out_time`, `stop_time`, `km`, `create_time`, `update_time`) VALUES (1753742642115645440, '2024-02-03', '1151', 1, '北京南', 'beijingnan', '07:00:00', '07:07:00', '00:07:00', 0.00, '2024-02-03 19:30:03.500', '2024-02-03 19:30:03.500');
INSERT INTO `daily_train_station` (`id`, `date`, `train_code`, `index`, `name`, `name_pinyin`, `in_time`, `out_time`, `stop_time`, `km`, `create_time`, `update_time`) VALUES (1753742642170171392, '2024-02-03', '1151', 2, '天津', 'tianjin', '08:00:00', '00:08:00', '16:08:00', 10.00, '2024-02-03 19:30:03.513', '2024-02-03 19:30:03.513');
INSERT INTO `daily_train_station` (`id`, `date`, `train_code`, `index`, `name`, `name_pinyin`, `in_time`, `out_time`, `stop_time`, `km`, `create_time`, `update_time`) VALUES (1753742642237280256, '2024-02-03', '1151', 3, '苏州', 'suzhou', '14:00:00', '14:07:00', '00:07:00', 30.00, '2024-02-03 19:30:03.529', '2024-02-03 19:30:03.529');
INSERT INTO `daily_train_station` (`id`, `date`, `train_code`, `index`, `name`, `name_pinyin`, `in_time`, `out_time`, `stop_time`, `km`, `create_time`, `update_time`) VALUES (1753742642296000512, '2024-02-03', '1151', 4, '上海-虹桥', 'shanghai-hongqiao', '17:00:00', '17:00:00', '00:00:00', 40.00, '2024-02-03 19:30:03.543', '2024-02-03 19:30:03.543');
COMMIT;

-- ----------------------------
-- Table structure for daily_train_ticket
-- ----------------------------
DROP TABLE IF EXISTS `daily_train_ticket`;
CREATE TABLE `daily_train_ticket` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `date` date NOT NULL COMMENT '日期',
  `train_code` varchar(20) NOT NULL COMMENT '车次编号',
  `start` varchar(20) NOT NULL COMMENT '出发站',
  `start_pinyin` varchar(50) NOT NULL COMMENT '出发站拼音',
  `start_time` time NOT NULL COMMENT '出发时间',
  `start_index` int(11) NOT NULL COMMENT '出发站序|本站是整个车次的第几站',
  `end` varchar(20) NOT NULL COMMENT '到达站',
  `end_pinyin` varchar(50) NOT NULL COMMENT '到达站拼音',
  `end_time` time NOT NULL COMMENT '到站时间',
  `end_index` int(11) NOT NULL COMMENT '到站站序|本站是整个车次的第几站',
  `ydz` int(11) NOT NULL COMMENT '一等座余票',
  `ydz_price` decimal(8,2) NOT NULL COMMENT '一等座票价',
  `edz` int(11) NOT NULL COMMENT '二等座余票',
  `edz_price` decimal(8,2) NOT NULL COMMENT '二等座票价',
  `rw` int(11) NOT NULL COMMENT '软卧余票',
  `rw_price` decimal(8,2) NOT NULL COMMENT '软卧票价',
  `yw` int(11) NOT NULL COMMENT '硬卧余票',
  `yw_price` decimal(8,2) NOT NULL COMMENT '硬卧票价',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `date_train_code_start_end_unique` (`date`,`train_code`,`start`,`end`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='余票信息';

-- ----------------------------
-- Records of daily_train_ticket
-- ----------------------------
BEGIN;
INSERT INTO `daily_train_ticket` (`id`, `date`, `train_code`, `start`, `start_pinyin`, `start_time`, `start_index`, `end`, `end_pinyin`, `end_time`, `end_index`, `ydz`, `ydz_price`, `edz`, `edz_price`, `rw`, `rw_price`, `yw`, `yw_price`, `create_time`, `update_time`) VALUES (1753742659412955136, '2024-02-03', '1151', '北京南', 'beijingnan', '07:07:00', 1, '天津', 'tianjin', '08:00:00', 2, 20, 4.80, -1, 3.60, -1, 7.20, -1, 6.00, '2024-02-03 19:30:07.623', '2024-02-03 19:30:07.623');
INSERT INTO `daily_train_ticket` (`id`, `date`, `train_code`, `start`, `start_pinyin`, `start_time`, `start_index`, `end`, `end_pinyin`, `end_time`, `end_index`, `ydz`, `ydz_price`, `edz`, `edz_price`, `rw`, `rw_price`, `yw`, `yw_price`, `create_time`, `update_time`) VALUES (1753742659622670336, '2024-02-03', '1151', '北京南', 'beijingnan', '07:07:00', 1, '苏州', 'suzhou', '14:00:00', 3, 20, 19.20, -1, 14.40, -1, 28.80, -1, 24.00, '2024-02-03 19:30:07.623', '2024-02-03 19:30:07.623');
INSERT INTO `daily_train_ticket` (`id`, `date`, `train_code`, `start`, `start_pinyin`, `start_time`, `start_index`, `end`, `end_pinyin`, `end_time`, `end_index`, `ydz`, `ydz_price`, `edz`, `edz_price`, `rw`, `rw_price`, `yw`, `yw_price`, `create_time`, `update_time`) VALUES (1753742660625108992, '2024-02-03', '1151', '北京南', 'beijingnan', '07:07:00', 1, '上海-虹桥', 'shanghai-hongqiao', '17:00:00', 4, 20, 38.40, -1, 28.80, -1, 57.60, -1, 48.00, '2024-02-03 19:30:07.623', '2024-02-03 19:30:07.623');
INSERT INTO `daily_train_ticket` (`id`, `date`, `train_code`, `start`, `start_pinyin`, `start_time`, `start_index`, `end`, `end_pinyin`, `end_time`, `end_index`, `ydz`, `ydz_price`, `edz`, `edz_price`, `rw`, `rw_price`, `yw`, `yw_price`, `create_time`, `update_time`) VALUES (1753742661078093824, '2024-02-03', '1151', '天津', 'tianjin', '00:08:00', 2, '苏州', 'suzhou', '14:00:00', 3, 20, 14.40, -1, 10.80, -1, 21.60, -1, 18.00, '2024-02-03 19:30:07.623', '2024-02-03 19:30:07.623');
INSERT INTO `daily_train_ticket` (`id`, `date`, `train_code`, `start`, `start_pinyin`, `start_time`, `start_index`, `end`, `end_pinyin`, `end_time`, `end_index`, `ydz`, `ydz_price`, `edz`, `edz_price`, `rw`, `rw_price`, `yw`, `yw_price`, `create_time`, `update_time`) VALUES (1753742661388472320, '2024-02-03', '1151', '天津', 'tianjin', '00:08:00', 2, '上海-虹桥', 'shanghai-hongqiao', '17:00:00', 4, 20, 33.60, -1, 25.20, -1, 50.40, -1, 42.00, '2024-02-03 19:30:07.623', '2024-02-03 19:30:07.623');
INSERT INTO `daily_train_ticket` (`id`, `date`, `train_code`, `start`, `start_pinyin`, `start_time`, `start_index`, `end`, `end_pinyin`, `end_time`, `end_index`, `ydz`, `ydz_price`, `edz`, `edz_price`, `rw`, `rw_price`, `yw`, `yw_price`, `create_time`, `update_time`) VALUES (1753742661539467264, '2024-02-03', '1151', '苏州', 'suzhou', '14:07:00', 3, '上海-虹桥', 'shanghai-hongqiao', '17:00:00', 4, 20, 19.20, -1, 14.40, -1, 28.80, -1, 24.00, '2024-02-03 19:30:07.623', '2024-02-03 19:30:07.623');
COMMIT;

-- ----------------------------
-- Table structure for station
-- ----------------------------
DROP TABLE IF EXISTS `station`;
CREATE TABLE `station` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `name` varchar(20) NOT NULL COMMENT '站名',
  `name_pinyin` varchar(50) NOT NULL COMMENT '站名拼音',
  `name_py` varchar(50) NOT NULL COMMENT '站名拼音首字母',
  `create_time` datetime(3) NOT NULL COMMENT '新增时间',
  `update_time` datetime(3) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `member_id_index` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='车站';

-- ----------------------------
-- Records of station
-- ----------------------------
BEGIN;
INSERT INTO `station` (`id`, `name`, `name_pinyin`, `name_py`, `create_time`, `update_time`) VALUES (1740739727214120960, '天津', 'tianjin', 'tj', '2023-12-29 22:21:06.984', '2023-12-29 22:21:06.984');
INSERT INTO `station` (`id`, `name`, `name_pinyin`, `name_py`, `create_time`, `update_time`) VALUES (1743294756462661632, '北京南', 'beijingnan', 'bjn', '2024-01-05 23:33:53.443', '2024-01-05 23:33:53.443');
INSERT INTO `station` (`id`, `name`, `name_pinyin`, `name_py`, `create_time`, `update_time`) VALUES (1743294804294504448, '上海-虹桥', 'shanghai-hongqiao', 'sh-hq', '2024-01-05 23:34:04.851', '2024-01-05 23:34:04.851');
INSERT INTO `station` (`id`, `name`, `name_pinyin`, `name_py`, `create_time`, `update_time`) VALUES (1750545668025487360, '苏州', 'suzhou', 'sz', '2024-01-25 23:46:25.464', '2024-01-25 23:46:25.464');
COMMIT;

-- ----------------------------
-- Table structure for train
-- ----------------------------
DROP TABLE IF EXISTS `train`;
CREATE TABLE `train` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `code` varchar(20) NOT NULL COMMENT '车次编号',
  `type` char(1) NOT NULL COMMENT '车次类型|枚举[TrainTypeEnum]',
  `start` varchar(20) NOT NULL COMMENT '始发站',
  `start_pinyin` varchar(50) NOT NULL COMMENT '始发站拼音',
  `start_time` time NOT NULL COMMENT '出发时间',
  `end` varchar(20) NOT NULL COMMENT '终点站',
  `end_pinyin` varchar(50) NOT NULL COMMENT '终点站拼音',
  `end_time` time NOT NULL COMMENT '到站时间',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='车次';

-- ----------------------------
-- Records of train
-- ----------------------------
BEGIN;
INSERT INTO `train` (`id`, `code`, `type`, `start`, `start_pinyin`, `start_time`, `end`, `end_pinyin`, `end_time`, `create_time`, `update_time`) VALUES (1739667512301326336, '1211', 'G', '北京南', 'beijingnan', '17:00:00', '苏州', 'suzhou', '20:00:00', '2023-12-26 23:20:30.000', '2024-01-26 00:12:55.670');
INSERT INTO `train` (`id`, `code`, `type`, `start`, `start_pinyin`, `start_time`, `end`, `end_pinyin`, `end_time`, `create_time`, `update_time`) VALUES (1743295290380783616, '1151', 'G', '北京南', 'beijingnan', '10:00:00', '上海-虹桥', 'shanghai-hongqiao', '14:00:00', '2024-01-05 23:36:00.743', '2024-01-05 23:36:00.743');
COMMIT;

-- ----------------------------
-- Table structure for train_carriage
-- ----------------------------
DROP TABLE IF EXISTS `train_carriage`;
CREATE TABLE `train_carriage` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `train_code` varchar(20) NOT NULL COMMENT '车次编号',
  `index` int(11) NOT NULL COMMENT '厢号',
  `seat_type` char(1) NOT NULL COMMENT '座位类型|枚举[SeatTypeEnum]',
  `seat_count` int(11) NOT NULL COMMENT '座位数',
  `row_count` int(11) NOT NULL COMMENT '排数',
  `col_count` int(11) NOT NULL COMMENT '列数',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `train_code_index_unique` (`train_code`,`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='火车车箱';

-- ----------------------------
-- Records of train_carriage
-- ----------------------------
BEGIN;
INSERT INTO `train_carriage` (`id`, `train_code`, `index`, `seat_type`, `seat_count`, `row_count`, `col_count`, `create_time`, `update_time`) VALUES (1743295721693646848, '1151', 1, '1', 10, 5, 2, '2024-01-05 23:37:43.576', '2024-01-05 23:37:43.576');
COMMIT;

-- ----------------------------
-- Table structure for train_seat
-- ----------------------------
DROP TABLE IF EXISTS `train_seat`;
CREATE TABLE `train_seat` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `train_code` varchar(20) NOT NULL COMMENT '车次编号',
  `carriage_index` int(11) NOT NULL COMMENT '厢序',
  `row` char(2) NOT NULL COMMENT '排号|01, 02',
  `col` char(1) NOT NULL COMMENT '列号|枚举[SeatColEnum]',
  `seat_type` char(1) NOT NULL COMMENT '座位类型|枚举[SeatTypeEnum]',
  `carriage_seat_index` int(11) NOT NULL COMMENT '同车厢座序',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='座位';

-- ----------------------------
-- Records of train_seat
-- ----------------------------
BEGIN;
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1740731820032528384, '2', 1, '1', 'A', '1', 1, '2023-12-29 21:49:41.000', '2023-12-29 21:49:49.168');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514651351715840, '1151', 1, '01', 'A', '1', 1, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514651464962048, '1151', 1, '01', 'C', '1', 2, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514651561431040, '1151', 1, '01', 'D', '1', 3, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514651653705728, '1151', 1, '01', 'F', '1', 4, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514651750174720, '1151', 1, '02', 'A', '1', 5, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514651842449408, '1151', 1, '02', 'C', '1', 6, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514651926335488, '1151', 1, '02', 'D', '1', 7, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514652022804480, '1151', 1, '02', 'F', '1', 8, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514652131856384, '1151', 1, '03', 'A', '1', 9, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514652228325376, '1151', 1, '03', 'C', '1', 10, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514652312211456, '1151', 1, '03', 'D', '1', 11, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514652396097536, '1151', 1, '03', 'F', '1', 12, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514652484177920, '1151', 1, '04', 'A', '1', 13, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514652580646912, '1151', 1, '04', 'C', '1', 14, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514652756807680, '1151', 1, '04', 'D', '1', 15, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514652870053888, '1151', 1, '04', 'F', '1', 16, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514653021048832, '1151', 1, '05', 'A', '1', 17, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514653096546304, '1151', 1, '05', 'C', '1', 18, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514653180432384, '1151', 1, '05', 'D', '1', 19, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
INSERT INTO `train_seat` (`id`, `train_code`, `carriage_index`, `row`, `col`, `seat_type`, `carriage_seat_index`, `create_time`, `update_time`) VALUES (1743514653272707072, '1151', 1, '05', 'F', '1', 20, '2024-01-06 14:07:12.161', '2024-01-06 14:07:12.161');
COMMIT;

-- ----------------------------
-- Table structure for train_station
-- ----------------------------
DROP TABLE IF EXISTS `train_station`;
CREATE TABLE `train_station` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `train_code` varchar(20) NOT NULL COMMENT '车次编号',
  `index` int(11) NOT NULL COMMENT '站序',
  `name` varchar(20) NOT NULL COMMENT '站名',
  `name_pinyin` varchar(50) NOT NULL COMMENT '站名拼音',
  `in_time` time DEFAULT NULL COMMENT '进站时间',
  `out_time` time DEFAULT NULL COMMENT '出站时间',
  `stop_time` time DEFAULT NULL COMMENT '停站时长',
  `km` decimal(8,2) NOT NULL COMMENT '里程（公里）|从上一站到本站的距离',
  `create_time` datetime(3) DEFAULT NULL COMMENT '新增时间',
  `update_time` datetime(3) DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `train_code_index_unique` (`train_code`,`index`),
  UNIQUE KEY `train_code_name_unique` (`train_code`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='火车车站';

-- ----------------------------
-- Records of train_station
-- ----------------------------
BEGIN;
INSERT INTO `train_station` (`id`, `train_code`, `index`, `name`, `name_pinyin`, `in_time`, `out_time`, `stop_time`, `km`, `create_time`, `update_time`) VALUES (1753717043380752384, '1151', 1, '北京南', 'beijingnan', '07:00:00', '07:07:00', '00:07:00', 0.00, '2024-02-03 17:48:20.270', '2024-02-03 17:48:20.270');
INSERT INTO `train_station` (`id`, `train_code`, `index`, `name`, `name_pinyin`, `in_time`, `out_time`, `stop_time`, `km`, `create_time`, `update_time`) VALUES (1753717141510688768, '1151', 2, '天津', 'tianjin', '08:00:00', '00:08:00', '16:08:00', 10.00, '2024-02-03 17:48:43.641', '2024-02-03 17:48:43.641');
INSERT INTO `train_station` (`id`, `train_code`, `index`, `name`, `name_pinyin`, `in_time`, `out_time`, `stop_time`, `km`, `create_time`, `update_time`) VALUES (1753717310922821632, '1151', 3, '苏州', 'suzhou', '14:00:00', '14:07:00', '00:07:00', 30.00, '2024-02-03 17:49:23.959', '2024-02-03 17:49:23.959');
INSERT INTO `train_station` (`id`, `train_code`, `index`, `name`, `name_pinyin`, `in_time`, `out_time`, `stop_time`, `km`, `create_time`, `update_time`) VALUES (1753717412865380352, '1151', 4, '上海-虹桥', 'shanghai-hongqiao', '17:00:00', '17:00:00', '00:00:00', 40.00, '2024-02-03 17:49:48.359', '2024-02-03 17:49:48.359');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
