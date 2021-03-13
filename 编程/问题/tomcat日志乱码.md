## tomcat日志中出现“淇℃伅”的乱码

### 问题

本地启动调试，控制台输出日志出现乱码

> 淇℃伅

### 解决方式

修改/conf/logging.properties文件

```properties
# java.util.logging.ConsoleHandler.encoding = UTF-8
java.util.logging.ConsoleHandler.encoding = GBK
```

