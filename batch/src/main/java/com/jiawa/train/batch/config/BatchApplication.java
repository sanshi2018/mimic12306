package com.jiawa.train.batch.config;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.env.ConfigurableEnvironment;

@Slf4j
@SpringBootApplication
@ComponentScan("com.jiawa")
@MapperScan("com.jiawa.train.*.mapper")
public class BatchApplication {

    public static void main(String[] args) {
        SpringApplication application = new SpringApplication(BatchApplication.class);
        ConfigurableEnvironment env = application.run(args).getEnvironment();
        log.info("启动成功！");
        log.info("测试地址: \thttp://127.0.0.1:{}{}/hello", env.getProperty("server.port"), env.getProperty("server.servlet.context-path"));
    }
}
