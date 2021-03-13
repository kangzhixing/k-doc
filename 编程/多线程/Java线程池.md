## 线城池处理任务的优先级

如果此时线程池中的数量小于corePoolSize，即使线程池中的线程都处于空闲状态，也要创建新的线程来处理被添加的任务。 
如果此时线程池中的数量等于 corePoolSize，但是缓冲队列 workQueue未满，那么任务被放入缓冲队列。 
如果此时线程池中的数量大于corePoolSize，缓冲队列workQueue满，并且线程池中的数量小于maximumPoolSize，建新的线程来处理被添加的任务。 
如果此时线程池中的数量大于corePoolSize，缓冲队列workQueue满，并且线程池中的数量等于maximumPoolSize，那么通过 handler所指定的策略来处理此任务。

**核心线程corePoolSize、任务队列workQueue、最大线程maximumPoolSize，如果三者都满了，使用handler处理被拒绝的任务。**

## Handler拒绝策略

- ThreadPoolExecutor.AbortPolicy() 
抛出java.util.concurrent.RejectedExecutionException异常  
- ThreadPoolExecutor.CallerRunsPolicy() 
直接在execute()方法的调用线程中运行被拒绝的任务；如果执行程序已关闭，则会丢弃该任务  
- ThreadPoolExecutor.DiscardOldestPolicy() 
抛弃旧的任务 
- ThreadPoolExecutor.DiscardPolicy() 
抛弃当前的任务

## Java通过Executors提供四种线程池，分别为：
**newCachedThreadPool**创建一个可缓存线程池  
如果线程池长度超过处理需要，可灵活回收空闲线程，若无可回收，则新建线程。

**newFixedThreadPool**创建一个定长线程池  
可控制线程最大并发数，超出的线程会在队列中等待。

**newScheduledThreadPool**创建一个周期线程池  
支持定时及周期性任务执行。

**newSingleThreadExecutor**创建一个单线程化的线程池  
它只会用唯一的工作线程来执行任务，保证所有任务按照指定顺序(FIFO, LIFO, 优先级)执行。

### newCachedThreadPool
创建一个可缓存线程池，如果线程池长度超过处理需要，可灵活回收空闲线程，若无可回收，则新建线程。示例代码如下：

```Java
ExecutorService cachedThreadPool = Executors.newCachedThreadPool();
for (int i = 0; i < 10; i++) {
    final int index = i;
    try {
        Thread.sleep(index * 1000);
    } catch (InterruptedException e) {
        e.printStackTrace();
    }
      
    cachedThreadPool.execute(new Runnable() {
        @Override
        public void run() {
            System.out.println(index);
        }
    });
}
```
线程池为无限大，当执行第二个任务时第一个任务已经完成，会复用执行第一个任务的线程，而不用每次新建线程。

### newFixedThreadPool
创建一个定长线程池，可控制线程最大并发数，超出的线程会在队列中等待。示例代码如下：

```Java
ExecutorService fixedThreadPool = Executors.newFixedThreadPool(3);
for (int i = 0; i < 10; i++) {
    final int index = i;
    fixedThreadPool.execute(new Runnable() {
        @Override
        public void run() {
            try {
                System.out.println(index);
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    });
}
```

因为线程池大小为3，每个任务输出index后sleep 2秒，所以每两秒打印3个数字。

定长线程池的大小最好根据系统资源进行设置。如Runtime.getRuntime().availableProcessors()。可参考PreloadDataCache。

### newScheduledThreadPool
创建一个周期线程池，支持定时及周期性任务执行。延迟执行示例代码如下：

```Java
ScheduledExecutorService scheduledThreadPool = Executors.newScheduledThreadPool(5);
scheduledThreadPool.schedule(new Runnable() {
    @Override
    public void run() {
        System.out.println("delay 3 seconds");
    }
}, 3, TimeUnit.SECONDS);
```
表示延迟3秒执行。

定期执行示例代码如下：

```Java
scheduledThreadPool.scheduleAtFixedRate(new Runnable() {
  
@Override
public void run() {
System.out.println("delay 1 seconds, and excute every 3 seconds");
}
}, 1, 3, TimeUnit.SECONDS);
```
表示延迟1秒后每3秒执行一次。

ScheduledExecutorService比Timer更安全，功能更强大，后面会有一篇单独进行对比。
### newSingleThreadExecutor
创建一个单线程化的线程池，它只会用唯一的工作线程来执行任务，保证所有任务按照指定顺序(FIFO, LIFO, 优先级)执行。示例代码如下：

```Java
ExecutorService singleThreadExecutor = Executors.newSingleThreadExecutor();
for (int i = 0; i < 10; i++) {
    final int index = i;
    singleThreadExecutor.execute(new Runnable() {
        @Override
        public void run() {
            try {
                System.out.println(index);
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
    });
}
```
结果依次输出，相当于顺序执行各个任务。

现行大多数GUI程序都是单线程的。Android中单线程可用于数据库操作，文件操作，应用批量安装，应用批量删除等不适合并发但可能IO阻塞性及影响UI线程响应的操作。

### 弊端
1）FixedThreadPool 和 SingleThreadPool: 允许的请求队列长度为 Integer.MAX_VALUE，可能会堆积大量的请求，从而导致 OOM。

2）CachedThreadPool 和 ScheduledThreadPool: 允许的创建线程数量为 Integer.MAX_VALUE，可能会创建大量的线程，从而导致 OOM。
### 如何设置线程超时时间
Future.get(超时时间，时间单位)

### 服务器端最佳线程数量
服务器端最佳线程数量 = ((线程等待时间 + 线程cpu时间) / 线程cpu时间) * cpu数量

### keepAliveTime
那么超出核心线程数并小于最大线程数的可能新创建的这部分线程相当于是“借”的，如果这20个线程空闲时间超过keepAliveTime，就会被退出。
底层代码：
getTask方法从缓存队列中通过poll(超时时间，时间单位)方法拉取任务，如果超过超时时间没有拉取到，则返回null