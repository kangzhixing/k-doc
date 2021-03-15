# @Async

### 如何在spring中开启多线程

首先需要使用@EnableAsync注解全局开启spring线程池，该注解通常标记在springboot启动类或者spring线程池配置类上。

然后@Async标记的方法会在bean初始化时注册到线程池中

### spring线程池配置类

```java
@Configuration
public class ThreadPoolTaskConfig {
 
    @Bean
    public Executor executor(){
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        //此方法返回可用处理器的虚拟机的最大数量; 不小于1
        int core = Runtime.getRuntime().availableProcessors();
        executor.setCorePoolSize(core);//设置核心线程数，默认为1
        executor.setMaxPoolSize(core * 2 + 1);//设置最大线程数，默认为Integer.MAX_VALUE
        executor.setKeepAliveSeconds(3);//除核心线程外的线程存活时间，默认为60s
        executor.setQueueCapacity(40);//如果传入值大于0，底层队列使用的是LinkedBlockingQueue,否则使用SynchronousQueue，默认为Integer.MAX_VALUE
        executor.setThreadNamePrefix("thread-execute");//线程名称前缀
        executor.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());//设置拒绝策略
        return executor;
    }
}
```

layout.tobs.jd.com design.tobs.jd.com