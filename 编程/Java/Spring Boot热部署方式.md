## Spring Boot热部署方式

POM添加引用，build后生效
```
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <optional>true</optional>
</dependency>
```
配置文件中添加配置，防止build后自动重启

```properties
spring.devtools.restart.enabled=false
```