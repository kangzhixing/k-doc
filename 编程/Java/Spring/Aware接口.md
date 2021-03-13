## Aware接口

> ## aware
>
> adj.	知道; 意识到; 明白; 察觉到; 发觉; 发现; 对…有兴趣的; 有…意识的;

当bean实现了对应的Aware接口，BeanFactory 就会在产生这个bean的时候根据对应的Aware接口，给这个bean注入相应的属性，这样bean就能够获取外界资源的引用了.

### 1. BeanNameAware

```java
public interface BeanNameAware {
    void setBeanName(String name) throws BeansException;
}
```


继承该接口，将实现setBeanName方法，bean的实例会被注入该bean的名称。

### 2. ApplicationContextAware

```java
public interface ApplicationContextAware {
    void setApplicationContext(ApplicationContext applicationContext) throws BeansException;
}
```


获取spring上下文

### 3. BeanFactoryAware

获取beanFactory

### 4. 其他

| 接口                             | 注入的属性                                                   | Explained in…                                                |
| -------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ApplicationContextAware        | Declaring ApplicationContext.                              | [ApplicationContextAware and BeanNameAware](https://docs.spring.io/spring/docs/5.1.4.RELEASE/spring-framework-reference/core.html#beans-factory-aware) |
| ApplicationEventPublisherAware | Event publisher of the enclosing ApplicationContext.       | [Additional Capabilities of the ApplicationContext](https://docs.spring.io/spring/docs/5.1.4.RELEASE/spring-framework-reference/core.html#context-introduction) |
| BeanClassLoaderAware           | Class loader used to load the bean classes.                  | [Instantiating Beans](https://docs.spring.io/spring/docs/5.1.4.RELEASE/spring-framework-reference/core.html#beans-factory-class) |
| BeanFactoryAware               | Declaring BeanFactory.                                     | [ApplicationContextAware and BeanNameAware](https://docs.spring.io/spring/docs/5.1.4.RELEASE/spring-framework-reference/core.html#beans-factory-aware) |
| BeanNameAware                  | Name of the declaring bean.                                  | [ApplicationContextAware and BeanNameAware](https://docs.spring.io/spring/docs/5.1.4.RELEASE/spring-framework-reference/core.html#beans-factory-aware) |
| BootstrapContextAware          | Resource adapter BootstrapContextthe container runs in. Typically available only in JCA aware ApplicationContextinstances. | [JCA CCI](https://docs.spring.io/spring/docs/5.1.4.RELEASE/spring-framework-reference/integration.html#cci) |
| LoadTimeWeaverAware            | Defined weaver for processing class definition at load time. | [Load-time Weaving with AspectJ in the Spring Framework](https://docs.spring.io/spring/docs/5.1.4.RELEASE/spring-framework-reference/core.html#aop-aj-ltw) |
| MessageSourceAware             | Configured strategy for resolving messages (with support for parametrization and internationalization). | [Additional Capabilities of the ApplicationContext](https://docs.spring.io/spring/docs/5.1.4.RELEASE/spring-framework-reference/core.html#context-introduction) |
| NotificationPublisherAware     | Spring JMX notification publisher.                           | [Notifications](https://docs.spring.io/spring/docs/5.1.4.RELEASE/spring-framework-reference/integration.html#jmx-notifications) |
| ResourceLoaderAware            | Configured loader for low-level access to resources.         | [Resources](https://docs.spring.io/spring/docs/5.1.4.RELEASE/spring-framework-reference/core.html#resources) |
| ServletConfigAware             | Current ServletConfig the container runs in. Valid only in a web-aware Spring ApplicationContext. | [Spring MVC](https://docs.spring.io/spring/docs/5.1.4.RELEASE/spring-framework-reference/web.html#mvc) |
| ServletContextAware            | Current ServletContext the container runs in. Valid only in a web-aware Spring ApplicationContext. | [Spring MVC](https://docs.spring.io/spring/docs/5.1.4.RELEASE/spring-framework-reference/web.html#mvc) |