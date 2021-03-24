# reflections使用

### 所依赖包

```xml
<dependency>
    <groupId>org.reflections</groupId>
    <artifactId>reflections</artifactId>
    <version>0.9.11</version>
</dependency>
<!-- 依赖guava包 -->
<dependency>
    <groupId>com.google.guava</groupId>
    <artifactId>guava</artifactId>
    <version>21.0</version>
</dependency>
```

### 核心方法

```java
Reflections reflections = new Reflections("com.jd.jr.tobs.pageconfig.provider.facade.*", new MethodAnnotationsScanner());
//比如可以获取有Pay注解的class
Set<Method> methods = reflections.getMethodsAnnotatedWith(SupportVersion.class);
```

### 源码分析

#### Reflections对象中包含两个属性：

```java
public class Reflections {
    protected final transient Configuration configuration;
	protected Store store;
}
```

其中configuration包含扫描方式、扫描位置、classLoader、执行服务、元数据适配器等

#### 扫描方式有如下实现：

```java
org.reflections.scanners.AbstractScanner
org.reflections.scanners.FieldAnnotationsScanner
org.reflections.scanners.MemberUsageScanner
org.reflections.scanners.MethodAnnotationsScanner
org.reflections.scanners.MethodParameterNamesScanner
org.reflections.scanners.MethodParameterScanner
org.reflections.scanners.ResourcesScanner
org.reflections.scanners.Scanner
org.reflections.scanners.SubTypesScanner
org.reflections.scanners.TypeAnnotationsScanner
org.reflections.scanners.TypeElementsScanner
org.reflections.scanners.TypesScanner
```

构造器中根据传入scanner不同，会将扫描结果以key为扫描方式，value为扫描结果的Map存入Reflections对象的store中。

```java
public class Store {
    private transient boolean concurrent;
    private final Map<String, Multimap<String, String>> storeMap;        
}
```



初始化完成后，即可使用reflections类提供的各种筛选方法获取store中扫描结果

#### 注意：

获取扫描结果时，如果获取方式对应的扫描方式为空，会抛出错误如下：

```java
Scanner XXX was not configured
```

