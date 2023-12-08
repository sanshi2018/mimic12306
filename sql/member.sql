drop table if exists `member`;
create table `member` (
    `id` bigint not null comment 'id',
    `mobile` varchar(11) comment '手机号',
    primary key (`id`),
    unique key `mobile_unique` (`mobile`)
) engine =innodb default charset=utf8mb4 comment ='会员';

drop table if exists `passenger`;
create table `passenger` (
    `id` bigint not null comment 'id',
    `member_id` bigint not null comment '会员id',
    `name` varchar(20) not null comment '姓名',
    `id_card` varchar(18) not null comment '身份证号',
    `type` char(1) not null comment '旅客类型|枚举[PassengerTypeEnum]',
    # datetime(3) 表示精确到毫秒
    `create_time` datetime(3) not null comment '创建时间',
    `update_time` datetime(3) not null comment '更新时间',
    primary key (`id`),
    key `member_id_index` (`member_id`)
) engine =innodb default charset=utf8mb4 comment ='乘车人';