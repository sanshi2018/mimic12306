package com.jiawa.train.gateway.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@Slf4j
@SpringBootApplication
// 因为启动类在config包内，如果未做任何配置，则只能扫描到其所在的包内。
// 所以需要添加componentScan扫描其他目录
@ComponentScan("com.jiawa.train.gateway")
public class GateWayApplication {
    public static void main(String[] args) {
        SpringApplication.run(GateWayApplication.class, args);

    }

}
