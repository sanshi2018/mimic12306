drop table if exists `station`;
create table `station` (
    `id` bigint not null comment 'id',
    `name` varchar(20) not null comment '站名',
    `name_pinyin` varchar(50) not null comment '站名拼音',
    `name_py` varchar(50) not null comment '站名拼音首字母',
    # datetime(3) 表示精确到毫秒
    `create_time` datetime(3) not null comment '新增时间',
    `update_time` datetime(3) not null comment '修改时间',
    primary key (`id`),
    key `member_id_index` (`name`)
) engine =innodb default charset=utf8mb4 comment ='车站';