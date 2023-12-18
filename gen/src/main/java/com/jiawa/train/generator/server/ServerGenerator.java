package com.jiawa.train.generator.server;


import com.jiawa.train.generator.util.FreemarkerUtil;
import freemarker.template.TemplateException;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class ServerGenerator {
    static String toPath = "gen/src/main/java/com/jiawa/train/generator/test/";
    static String pomPath ="gen/pom.xml";
    static {
        new File(toPath).mkdirs();
    }

    public static void main(String[] args) throws IOException, TemplateException, DocumentException {
        // 输出程序运行的当前目录
//        System.out.println(System.getProperty("user.dir"));
//        FreemarkerUtil.initConfig("test.ftl");
//        Map<String, Object> param = new HashMap<>();
//        param.put("domain", "Test1");
//        FreemarkerUtil.generator(toPath + "Test1.java", param);
        SAXReader saxReader = new SAXReader();
        HashMap<String, String> map = new HashMap<>();
        map.put("pom", "http://maven.apache.org/POM/4.0.0");
        saxReader.getDocumentFactory().setXPathNamespaceURIs(map);
        Document document = saxReader.read(pomPath);
        Node node = document.selectSingleNode("//pom:configurationFile");
        System.out.println(node.getText());
    }
}