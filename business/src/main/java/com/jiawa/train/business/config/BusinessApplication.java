package com.jiawa.train.business.config;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.env.ConfigurableEnvironment;

@Slf4j
@SpringBootApplication
// 因为启动类在config包内，如果未做任何配置，则只能扫描到其所在的包内。
// 所以需要添加componentScan扫描其他目录
@ComponentScan("com.jiawa")
@MapperScan("com.jiawa.train.*.mapper")
public class BusinessApplication {
    public static void main(String[] args) {
        ConfigurableApplicationContext app = SpringApplication.run(BusinessApplication.class, args);
        ConfigurableEnvironment env = app.getEnvironment();
        log.info("启动成功！");
        log.info("测试地址: \thttp://127.0.0.1:{}{}/hello", env.getProperty("server.port"), env.getProperty("server.servlet.context-path"));

    }

}
