package com.jiawa.train.member.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@Slf4j
@SpringBootApplication
// 因为启动类在config包内，如果未做任何配置，则只能扫描到其所在的包内。
// 所以需要添加componentScan扫描其他目录
@ComponentScan("com.jiawa")
public class MemberApplication {
    public static void main(String[] args) {
        SpringApplication.run(MemberApplication.class, args);

    }

}
