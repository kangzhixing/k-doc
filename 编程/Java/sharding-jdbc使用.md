#### 逻辑表和实际表映射关系配置
https://msd.misuland.com/pd/2884250137616456546

默认配置
```Java
TableRule orderTableRule = new TableRule("t_order", Arrays.asList("t_order_0", "t_order_1"), dataSourceRule);
```
自定义规则配置
```Java
TableRule orderTableRule = new TableRule("t_order", Arrays.asList("db0.t_order_0", "db0.t_order_1", "db1.t_order_2", "db1.t_order_3", "db1.t_order_4"), dataSourceRule);
```

### 例：

```Sql
select * from t_order where user_id = ? and order_id = ?;
```
Sharding-JDBC将会将SQL语句转换为如下形式：
```Sql
select * from db0.t_order_0 where user_id = ? and order_id = ?;
```