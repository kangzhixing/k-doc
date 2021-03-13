## Mybatis-plus使用

### 1. 作用

​	封装mybatis，减少使用成本。

### 2. pom

```xml
<!-- spring boot环境 -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter</artifactId>
</dependency>
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <optional>true</optional>
</dependency>
<!-- MP核心jar包 -->
<dependency>
    <groupId>com.baomidou</groupId>
    <artifactId>mybatis-plus-boot-starter</artifactId>
    <version>3.3.1.tmp</version>
</dependency>
<!-- 数据库相关 -->
<dependency>
    <groupId>com.alibaba</groupId>
    <artifactId>druid-spring-boot-starter</artifactId>
    <version>1.1.9</version>
</dependency>
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.18</version>
</dependency>
```

### 3. mapper

```java
public interface TestTableMapper extends BaseMapper<TestTable> {

}
```

- 与BaseMapper接口中相同的方法将直接重写
- 复杂方法可使用mybatis的方式定义

### 4. Entity

```java
@Data
@TableName("t_test_table")
public class TestTable {
    private Long id;
    private String name;
}
```

### 5. 使用

```java
@Autowired
private UserMapper userMapper;

@Test
public void testSelect() {
    List<TestTable> userList = testTableMapper.selectList(null);
    // TODO ...
}
```