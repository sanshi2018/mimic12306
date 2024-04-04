/*
 Navicat Premium Data Transfer

 Source Server         : win_mysql
 Source Server Type    : MySQL
 Source Server Version : 50744
 Source Host           : 192.168.50.193:3306
 Source Schema         : train_member

 Target Server Type    : MySQL
 Target Server Version : 50744
 File Encoding         : 65001

 Date: 04/04/2024 23:49:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `mobile` varchar(11) DEFAULT NULL COMMENT '手机号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile_unique` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员';

-- ----------------------------
-- Records of member
-- ----------------------------
BEGIN;
INSERT INTO `member` (`id`, `mobile`) VALUES (1723230394377179136, '11123');
INSERT INTO `member` (`id`, `mobile`) VALUES (1699454443863, '1234');
INSERT INTO `member` (`id`, `mobile`) VALUES (1699455988779, '12345');
INSERT INTO `member` (`id`, `mobile`) VALUES (1723639643762724864, '13000000000');
INSERT INTO `member` (`id`, `mobile`) VALUES (1723632276731990016, '1530000');
INSERT INTO `member` (`id`, `mobile`) VALUES (1, '22');
COMMIT;

-- ----------------------------
-- Table structure for passenger
-- ----------------------------
DROP TABLE IF EXISTS `passenger`;
CREATE TABLE `passenger` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `member_id` bigint(20) NOT NULL COMMENT '会员id',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `id_card` varchar(18) NOT NULL COMMENT '身份证号',
  `type` char(1) NOT NULL COMMENT '旅客类型|枚举[PassengerTypeEnum]',
  `create_time` datetime(3) NOT NULL COMMENT '创建时间',
  `update_time` datetime(3) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `member_id_index` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='乘车人';

-- ----------------------------
-- Records of passenger
-- ----------------------------
BEGIN;
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1733131176517963776, 1, '1', '1', '1', '2023-12-08 22:27:27.135', '2023-12-08 22:27:27.135');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1733143061736853504, 1699454443863, '1', '1', '1', '2023-12-08 23:14:40.813', '2023-12-08 23:14:40.813');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1733143572183650304, 1699454443863, '1', '1', '1', '2023-12-08 23:16:42.516', '2023-12-08 23:16:42.516');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1733143827138613248, 1699454443863, '1', '1', '1', '2023-12-08 23:17:39.419', '2023-12-08 23:17:39.419');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1733143889415639040, 1699454443863, '1', '1', '1', '2023-12-08 23:17:55.186', '2023-12-08 23:17:55.186');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1733145114047549440, 1699454443863, '1', '1', '1', '2023-12-08 23:22:50.124', '2023-12-08 23:22:50.124');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1733145432231645184, 1699454443863, '1', '1', '1', '2023-12-08 23:24:05.983', '2023-12-08 23:24:05.983');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1734608487654232064, 1723639643762724864, '111', '111', '1', '2023-12-13 00:17:45.577', '2023-12-13 00:17:45.577');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138816, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138817, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138818, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138819, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138820, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138821, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138822, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138823, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138824, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138825, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138826, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138827, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138828, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138829, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138830, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138831, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138832, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138833, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138834, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138835, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138836, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138837, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138838, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138839, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138840, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138841, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138842, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138843, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736256477775138844, 1723639643762724864, 'sanshi', '123', '1', '2023-12-17 13:26:17.040', '2023-12-17 13:26:17.040');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736266088896925696, 1723639643762724864, 'ttt', '3123', '1', '2023-12-17 14:04:28.514', '2023-12-17 14:04:28.514');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736266156819484672, 1723639643762724864, 'ttt', '3123', '1', '2023-12-17 14:04:44.708', '2023-12-17 14:04:44.708');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736267355882917888, 1723639643762724864, '312', '321', '1', '2023-12-17 14:09:30.587', '2023-12-17 14:09:30.587');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736269617028009984, 1723639643762724864, '312', '3123', '1', '2023-12-17 14:18:29.686', '2023-12-17 14:18:29.686');
INSERT INTO `passenger` (`id`, `member_id`, `name`, `id_card`, `type`, `create_time`, `update_time`) VALUES (1736271163765690368, 1723639643762724864, '312', '312', '1', '2023-12-17 14:24:38.457', '2023-12-17 14:24:38.457');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
