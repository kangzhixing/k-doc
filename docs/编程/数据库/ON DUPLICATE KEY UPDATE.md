## ON DUPLICATE KEY UPDATE

### 作用

insert语句中如果造成唯一索引冲突，会执行失败。

某种业务场景下，我们需要在添加某个唯一索引失败时对该数据进行更改，mysql提供ON DUPLICATE KEY UPDATE命令完成该操作。

### 例子

如果id为5的数据不存在，则添加一条新数据；如果存在，则修改其"is_new"为"old"

```sql
insert into table_name ('id','is_new') values (5,'new') ON DUPLICATE KEY UPDATE set is_new = 'old'
```





