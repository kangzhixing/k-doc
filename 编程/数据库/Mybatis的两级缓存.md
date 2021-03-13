## Mybatis两级缓存
### 两级缓存
#### 一级缓存（默认开启）
相同sqlSession中，执行相同的SQL查询时，第一次会去查询数据库，并写在缓存中，第二次会直接从缓存中取。  
当执行SQL时候两次查询中间发生了增删改的操作，则SQLSession的缓存会被清空。

原理：Mybatis的内部缓存使用一个HashMap，key为hashcode+statementId+sql语句。Value为查询出来的结果集映射成的java对象。  
SqlSession执行insert、update、delete等操作commit后会清空该SQLSession缓存。
#### 二级缓存（默认不开启）
第一次调用mapper下的SQL去查询用户信息。查询到的信息会存到该mapper对应的二级缓存区域内。

第二次调用相同namespace下的mapper映射文件中相同的SQL去查询用户信息。会优先去对应的二级缓存内取结果。

如果调用相同namespace下的mapper映射文件中的增删改SQL，并执行了commit操作。此时会清空该namespace下的二级缓存。


### 如何开启二级缓存


1. 在核心配置文件SqlMapConfig.xml中加入以下内容（开启二级缓存总开关）：

cacheEnabled设置为true

```xml
<settings>
    <setting name="cacheEnabled" value="true"/>
</settings>
```

2. 在映射文件中，加入以下内容，开启二级缓存：
```xml
<mapper namespace="BlogMapper">
<cache/>
```

3. 查询结果映射的pojo对象需要实现java.io.Serializable接口实现序列化和反序列化操作，注意如果存在父类、成员pojo都需要实现序列化接口。  
为了将缓存数据取出执行反序列化，因为二级缓存存储介质多种多样，不一定在内存。

### 禁用查询操作保存二级缓存
statement中设置userCache=false可以禁用当前select语句的二级缓存，即每次查询都是去数据库中查询，默认情况下是true，即该statement使用二级缓存。

```xml
<select id="selectUsers" parameterType="java.lang.String" resultType="User" useCache="false">
select * from user_m where userName like #{userName}
</select>
```

### 禁用修改操作清空二级缓存
在mapper的同一个namespace中，如果有其它insert、update、delete操作数据后会自动刷新缓存，如果将flushCache改成false则不会刷新

```xml
<insert id="addUser" parameterType="User" flushCache="true">
insert into t_user (id, userName, userAge, userAddress)
values (#{id}, #{userName}, #{userAge}, #{userAddress})
</insert>
```