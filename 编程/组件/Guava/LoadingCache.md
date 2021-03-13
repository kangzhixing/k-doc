## LoadingCache的使用

### 1 POM

```xml
<dependency>
    <groupId>com.google.guava</groupId>
    <artifactId>guava</artifactId>
    <version>27.1-jre</version>
</dependency>
```

### 2 初始化

```java
LoadingCache<Long, String> cache = CacheBuilder.newBuilder()
                //缓存池大小，在缓存项接近该大小时， Guava开始回收旧的缓存项
                .maximumSize(GUAVA_CACHE_SIZE)
                //设置时间对象没有被读/写访问则对象从内存中删除(在另外的线程里面不定期维护)
                .expireAfterAccess(10, TimeUnit.MINUTES)
                //移除监听器,缓存项被移除时会触发
                .removalListener(new RemovalListener <Long, String>() {
                    @Override
                    public void onRemoval(RemovalNotification<Long, String> rn) {
                        //执行逻辑操作
                    }
                })
                //开启Guava Cache的统计功能
                .recordStats()
                .build(cacheLoader);
```

### 3 主要方法

```java
// 添加缓存
void put(K key, V value);

// 获取缓存，没有则执行load()方法后返回
V get(K key) throws ExecutionException;

// 获取缓存，没有则执行callable后返回
V get(K key, Callable<? extends V> loader) throws ExecutionException;
    
// 获取缓存，没有返回null
V getIfPresent(@CompatibleWith("K") Object key);

// 将key对应缓存置为失效
void invalidate(@CompatibleWith("K") Object key);

// 将所有缓存置为失效
void invalidateAll();
```



### 4 基于时间的清理或刷新缓存数据的方式

- expireAfterAccess: 当缓存项在指定的时间段内没有被读或写就会被回收。

- expireAfterWrite：当缓存项在指定的时间段内没有更新就会被回收。

- refreshAfterWrite：当缓存项上一次更新操作之后的多久会被刷新。

### 5 缺点

超时机制非精确