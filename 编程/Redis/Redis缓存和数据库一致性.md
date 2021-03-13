## Redis缓存和数据库一致性

1.延时双删策略
```java
public void write(String key,Object data){
    redisUtils.del(key);
    db.update(data);
    Thread.Sleep(100);
    redisUtils.del(key);
}
```
2.更新数据库的地方和读取的地方上同样key的分布式锁