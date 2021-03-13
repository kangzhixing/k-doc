## dump日志方法

- 在jvm启动的参数中，新增-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/home/admin/logs/java.hprof jvm参数。这样在发生jvm 内存溢出时，就会直接dump出java.hprof 文件了

- 使用jmap导出jvm内存信息

  ```shell
  jmap -dump:format=b,file=/home/admin/logs/heap.hprof  javapid
  ```

- jstack可以查看当前java进程的dump信息

  ```shell
  jstack pid
  ```

## dump日志分析

- “http-nio-8081-exec-10” 线程名称
- #25 线程编号
- daemon 线程的类型
- prio=5 线程的优先级别
- os_prio=0 系统级别的线程优先级
- tid=0x00007f87e028c000 线程ID
- nid=0x6724 native线程的id
- waiting on condition [0x00007f87b97d2000] 线程当前的状态

## 线程状态

- runnable：运行中状态，在虚拟机内部执行，可能已经获取到了锁，可以观察是否有locked字样。
- blocked：被阻塞并等待锁的释放。
- wating：处于等待状态，等待特定的操作被唤醒，一般停留在park(), wait(), sleep(),join() 等语句里。
- time_wating：有时限的等待另一个线程的特定操作。
- terminated：线程已经退出。

## 方法调用修饰
- locked: 成功获取锁
- waiting to lock：还未获取到锁，在进入去等待；
- waiting on：获取到锁之后，又释放锁，在等待区等待；
- parking to wait for：等待许可证； （参考LockSupport.park和unpark操作）