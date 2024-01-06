package com.jiawa.train.generator.gen;


import com.jiawa.train.generator.util.DbUtil;
import com.jiawa.train.generator.util.Field;
import com.jiawa.train.generator.util.FreemarkerUtil;
import freemarker.template.TemplateException;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class ServerGenerator {
    static boolean readOnly = true;
    static String vuePath = "web/tem/";
    static String module = "business";
    static String serverPath = "[module]/src/main/java/com/jiawa/train/"+module+"/";
    static String pomPath ="gen/pom.xml";
    static {
        new File(serverPath).mkdirs();
    }

    public static void main(String[] args) throws Exception {
        // 输出程序运行的当前目录
//        System.out.println(System.getProperty("user.dir"));
//        FreemarkerUtil.initConfig("test.ftl");
//        Map<String, Object> param = new HashMap<>();
//        param.put("domain", "Test1");
//        FreemarkerUtil.generator(toPath + "Test1.java", param);

        // 读取pom.xml中的配置文件 <configurationFile/>
        Node node = getGeneratorPath();
        // 比如generator-config-member.xml，得到module = member
        String module = node.getText().replace("src/main/resources/generator-config-", "").replace(".xml", "");
        System.out.println("module: " + module);
        // 得到真实输出目录
        serverPath = serverPath.replace("[module]", module);
        // new File(servicePath).mkdirs();
        System.out.println("servicePath: " + serverPath);


        // 找到 xml文件
        Document document = new SAXReader().read("gen/" + node.getText());

        Node table = document.selectSingleNode("//table");
        System.out.println(table);
        Node tableName = table.selectSingleNode("@tableName");
        // 类名
        Node domainObjectName = table.selectSingleNode("@domainObjectName");
        System.out.println(tableName.getText()+"/"+ domainObjectName.getText());

        // ---------数据库相关
        Node connectionRUL = document.selectSingleNode("//@connectionURL");
        Node userId = document.selectSingleNode("//@userId");
        Node password = document.selectSingleNode("//@password");

        DbUtil.url = connectionRUL.getText();
        DbUtil.user = userId.getText();
        DbUtil.password = password.getText();


        // ---------数据库相关




        // 示例：表名 jiawa_test
        // Domain = JiawaTest
        String Domain = domainObjectName.getText();
        // domain = jiawaTest
        String domain = Domain.substring(0, 1).toLowerCase() + Domain.substring(1);
        // do_main = jiawa-test
        String do_main = tableName.getText().replaceAll("_", "-");

        // 数据库------------
        String tableComment = DbUtil.getTableComment(tableName.getText());
        List<Field> fieldList = DbUtil.getColumnByTableName(tableName.getText());
        Set<String> typeSet = getJavaType(fieldList);
        // 数据库------------

        // 组装参数
        Map<String, Object> param = new HashMap<>();
        param.put("Domain", Domain);
        param.put("domain", domain);
        param.put("do_main", do_main);
        param.put("module", module);

        param.put("tableNameCn", tableComment);
        param.put("typeSet", typeSet);
        param.put("fieldList", fieldList);
        param.put("readOnly", readOnly);

        System.out.println("组装参数：" + param);

//        gen(Domain, param, "controller/admin", "adminController");
//        gen(Domain, param, "service", "service");
//        gen(Domain, param, "req", "saveReq");
//        gen(Domain, param, "req", "queryReq");
//        gen(Domain, param, "resp", "queryResp");

        genVue(do_main, param);



    }

    /**
     * 获得所有的java类型
     * @param fieldList 字段列表
     */
    static Set<String> getJavaType(List<Field> fieldList) {
        Set<String> set = new HashSet<>();
        fieldList.forEach(field -> {
            set.add(field.getJavaType());
        });
        return set;
    }

    private static void gen(String Domain, Map<String, Object> param, String packageName,  String target) throws IOException, TemplateException {
        // 定义模板
        FreemarkerUtil.initConfig(target+".ftl");
        // 创建目标路径
        String toPath = serverPath + packageName + "/";
        new File(toPath).mkdirs();
        // 类名首字母大写
        String Target = target.substring(0, 1).toUpperCase() + target.substring(1);
        String fileNeme = toPath +Domain+ Target + ".java";

        System.out.println("开始生成：" + fileNeme);
        FreemarkerUtil.generator(fileNeme, param);
    }

    private static void genVue(String do_main, Map<String, Object> param) throws IOException, TemplateException {
        FreemarkerUtil.initConfig("vue.ftl");
        new File(vuePath).mkdirs();
        String fileName = vuePath + do_main + ".vue";
        System.out.println("开始生成：" + fileName);
        FreemarkerUtil.generator(fileName, param);
    }


    private static Node getGeneratorPath() throws DocumentException {
        SAXReader saxReader = new SAXReader();
        HashMap<String, String> map = new HashMap<>();
        map.put("pom", "http://maven.apache.org/POM/4.0.0");
        saxReader.getDocumentFactory().setXPathNamespaceURIs(map);
        Document document = saxReader.read(pomPath);
        Node node = document.selectSingleNode("//pom:configurationFile");
        System.out.println(node.getText());
        return node;
    }
}