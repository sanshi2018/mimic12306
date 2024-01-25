package com.jiawa.train.batch.controller;

import cn.hutool.core.date.DateTime;
import com.jiawa.train.batch.feign.BusinessFeign;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
public class TestController {

    @Resource
    BusinessFeign businessFeign;

    @GetMapping("/hello")
    public String hello() {
        businessFeign.genDaily(DateTime.now().toJdkDate());
        return "Hello ! Batch";
    }
}
