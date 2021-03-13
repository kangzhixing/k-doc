## Spring配置文件beans中的xmlns

```xml
<beans xmlns="http://www.springframework.org/schema/beans"
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 xmlns:context="http://www.springframework.org/schema/context"
 xmlns:mvc="http://www.springframework.org/schema/mvc"
 xsi:schemaLocation="http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-3.1.1.xsd
 http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
 http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-3.1.1.xsd">
```

因为xml文档都有格式，为了spring的配置文件增加的节点能满足要求、合法，所以引入校验该xml的格式文件。

xmlns是xml命名空间的意思，而xmlns:xsi是指xml所遵守的标签规范。

1.xmlns：关于初始化bean的格式文件地址

2.xmlns:xsi：辅助初始化bean

3.xsi:context：关于spring上下文，包括加载资源文件

4.xsi:schemaLocation：用于声明了目标名称空间的模式文档