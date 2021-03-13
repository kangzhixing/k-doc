## 1. 服务提供者

### 1.1 引入dubbo依赖jar包

```xml
<!-- 引入spring-boot-starter以及dubbo和curator的依赖 -->
<dependency>
    <groupId>com.alibaba.boot</groupId>
    <artifactId>dubbo-spring-boot-starter</artifactId>
    <version>0.2.0</version>
</dependency>
```
### 1.2 使用@Service注解暴露服务

```java
@Service
@Component
public class DubboServiceImpl implements DubboService {

    @Override
    public List<TestModel> getTestModel(String id) {
        //TODO
    }
}
```

### 1.3 设置application.properties

```properties
#当前服务/应用的名字
dubbo.application.name=dubbo-service-provider

#注册中心的协议和地址
dubbo.registry.protocol=zookeeper
dubbo.registry.address=127.0.0.1:2181

#通信规则（通信协议和接口）
dubbo.protocol.name=dubbo
dubbo.protocol.port=20880

#连接监控中心
dubbo.monitor.protocol=registry
#开启包扫描，可替代 @EnableDubbo 注解
##dubbo.scan.base-packages=com.zang.gmall
```

### 1.4 Spring容器配置启动服务方

```java
// 开启基于注解的dubbo功能（主要是包扫描@DubboComponentScan）
// 也可以在配置文件中使用dubbo.scan.base-package来替代   @EnableDubbo
@EnableDubbo
@SpringBootApplication
public class UserServiceProviderApplication {

    public static void main(String[] args) {
        SpringApplication.run(UserServiceProviderApplication.class, args);
    }
}
```

## 2. 服务消费者

### 1.1 引入同提供者相同jar包

### 1.2 设置application.properties

```properties
dubbo.application.name=dubbo-service-consumer
dubbo.registry.address=zookeeper://127.0.0.1:2181
dubbo.monitor.protocol=registry
```
### 1.3 使用@Reference声明service

```java
@Service
public class ConsumerServiceImpl implements ConsumerService {

    @Reference
    DubboService dubboService;

    @Override
    public List<TestModel> getModel(String id) {
　　    return dubboService.getTestModel(id);
    }
}
```