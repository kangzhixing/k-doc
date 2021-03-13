## 作用域

- ### singleton

  在spring IoC容器仅存在一个Bean实例，Bean以单例方式存在，默认值		

- ### prototype

  每次从容器中调用Bean时，都返回一个新的实例，即每次调用getBean()时，相当于执行newXxxBean()

- ### request

  每次HTTP请求都会创建一个新的Bean，该作用域仅适用于WebApplicationContext环境

- ### session

  同一个HTTP Session共享一个Bean，不同Session使用不同的Bean，仅适用于WebApplicationContext环境

- ### global-session

  一般用于Portlet应用环境，该运用域仅适用于WebApplicationContext环境

## Spring boot 下设置

```java
@Scope("prototype")
```

