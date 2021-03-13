### ReentrantLock 重入锁

重入锁代表一段代码可以被同一个线程多次进入，其中unlock()次数对应lock()的次数。

区别于jvm实现的synchronized关键字，ReentrantLock是Lock的实现，代码层级的锁，常在finally中调用unlock()释放锁，所以在程序崩溃情况下，有可能造成死锁。
```java
//创建一个非公平锁，默认是非公平锁
Lock nonFairLock= new ReentrantLock();
Lock nonFairLock= new ReentrantLock(false);

//创建一个公平锁，构造传参true
Lock fairLock= new ReentrantLock(true);
```

#### 公平锁 & 非公平锁
- 公平锁  
加锁前先查看是否有排队等待的线程，有的话优先处理排在前面的线程，先来先得。  
- 非公平锁  
线程加锁时直接尝试获取锁，获取不到就自动到队尾等待。

更多的是直接使用非公平锁：非公平锁比公平锁性能高5-10倍，因为公平锁需要在多核情况下维护一个队列，如果当前线程不是队列的第一个无法获取锁，增加了线程切换次数。

#### ReentrantLock和Synchronized区别
1. Lock是一个接口，而synchronized是关键字。
1. synchronized会自动释放锁，而Lock必须手动释放锁。
1. Lock可以让等待锁的线程响应中断，而synchronized不会，线程会一直等待下去。
1. 通过Lock可以知道线程有没有拿到锁，而synchronized不能。
1. Lock能提高多个线程读操作的效率。
1. synchronized能锁住类、方法和代码块，而Lock是块范围内的

#### Synchronized性能问题

Synchronized关键字会让没有得到锁资源的线程进入BLOCKED状态，而后在争夺到锁资源后恢复为RUNNABLE状态，这个过程中涉及到操作系统用户模式和内核模式的转换，代价比较高。

尽管Java1.6为Synchronized做了优化，增加了从偏向锁到轻量级锁再到重量级锁的过度，但是在最终转变为重量级锁之后，性能仍然较低。

#### Synchronized属于悲观锁，悲观地认为程序中的并发情况严重，所以严防死守。CAS属于乐观锁，乐观地认为程序中的并发情况不那么严重，所以让线程不断去尝试更新。

#### CAS的缺点

1.CPU开销较大

在并发量比较高的情况下，如果许多线程反复尝试更新某一个变量，却又一直更新不成功，循环往复，会给CPU带来很大的压力。

2.不能保证代码块的原子性

CAS机制所保证的只是一个变量的原子性操作，而不能保证整个代码块的原子性。比如需要保证3个变量共同进行原子性的更新，就不得不使用Synchronized了。

 因为它本身就只是一个锁住总线的原子交换操作啊。两个CAS操作之间并不能保证没有重入现象。

3.ABA问题

这是CAS机制最大的问题所在。