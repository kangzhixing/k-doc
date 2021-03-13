### 搭建
pom引入依赖
```xml
<!--web的起步依赖-->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
<!--声明为一个client -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>
<!--使用feign -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-openfeign</artifactId>
</dependency>
```
application.yml
```yml
server:
  port: 2089
spring:
  application:
    name: agamotto-feign
eureka:
  client:
    serviceUrl:
      defaultZone: http://localhost:2088/eureka/
```
Application中加入注解@EnableFeignClients
```java
@EnableFeignClients
@SpringBootApplication
public class AgamottoFeignApplication {

    public static void main(String[] args) {
        SpringApplication.run(AgamottoFeignApplication.class, args);
    }

}
```
定义feign接口，用来调用生产者
```java
@FeignClient(value="agamotto-core")
public interface CoreService {

    @RequestMapping("/test")
    String test();
}
```
任意位置注入使用
```java
@Autowired
CoreService coreService;

@GetMapping("test")
public String test(){
    return coreService.test();
}
```


