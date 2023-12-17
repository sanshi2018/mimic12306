package com.jiawa.train.generator.server;


import com.jiawa.train.generator.util.FreemarkerUtil;
import freemarker.template.TemplateException;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class ServerGenerator {
    static String toPath = "gen/src/main/java/com/jiawa/train/generator/test/";
    static {
        new File(toPath).mkdirs();
    }

    public static void main(String[] args) throws IOException, TemplateException {
        // 输出程序运行的当前目录
        System.out.println(System.getProperty("user.dir"));
        FreemarkerUtil.initConfig("test.ftl");
        Map<String, Object> param = new HashMap<>();
        param.put("domain", "Test1");
        FreemarkerUtil.generator(toPath + "Test1.java", param);
    }
}