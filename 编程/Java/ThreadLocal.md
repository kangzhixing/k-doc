## ThreadLocal

### ThreadLocal概念
ThreadLocal的作用是提供线程内的局部变量，这种变量在线程的生命周期内起作用。
主要用途：
- 保存线程上下文信息，在任意需要的地方可以获取
- 线程安全的，避免某些情况需要考虑线程安全必须同步带来的性能损失

### ThreadLocalMap
ThreadLocal内部有一个内部类ThreadLocalMap，类中用于存储数据的entry定义为：
```java
static class Entry extends WeakReference<ThreadLocal<?>> {
    /** The value associated with this ThreadLocal. */
    Object value;

    Entry(ThreadLocal<?> k, Object v) {
        super(k);
        value = v;
    }
}
```

通过ThreadLocal的get/set方法，可以发现，这个Map的key是ThreadLocal类的实例对象，value为用户的值。：
```java
public void set(T value) {
    Thread t = Thread.currentThread();
    ThreadLocalMap map = getMap(t);
    if (map != null)
        map.set(this, value);
    else
        createMap(t, value);
}

public T get() {
    Thread t = Thread.currentThread();
    ThreadLocalMap map = getMap(t);
    if (map != null) {
        ThreadLocalMap.Entry e = map.getEntry(this);
        if (e != null) {
            @SuppressWarnings("unchecked")
            T result = (T)e.value;
            return result;
        }
    }
    return setInitialValue();
}
```
getMap方法为：
```java
ThreadLocalMap getMap(Thread t) {
    return t.threadLocals;
}
```
**由于threadLocals的引用在Thread中，所以保证了线程安全。**

其中threadLocals初始化在createMap中：
```java
void createMap(Thread t, T firstValue) {
    t.threadLocals = new ThreadLocalMap(this, firstValue);
}
```
### 同一个线程中ThreadLocal对象的区分
```java
private final int threadLocalHashCode = nextHashCode();
private static AtomicInteger nextHashCode = new AtomicInteger();
private static final int HASH_INCREMENT = 0x61c88647;
private static int nextHashCode() {
      return nextHashCode.getAndAdd(HASH_INCREMENT);
}
```
对于每一个ThreadLocal对象，都有一个final修饰的int型的threadLocalHashCode不可变属性，对于基本数据类型，可以认为它在初始化后就不可以进行修改，所以可以唯一确定一个ThreadLocal对象。
　　但是如何保证两个同时实例化的ThreadLocal对象有不同的threadLocalHashCode属性：在ThreadLocal类中，还包含了一个static修饰的AtomicInteger（[əˈtɒmɪk]提供原子操作的Integer类）成员变量（即类变量）和一个static final修饰的常量（作为两个相邻nextHashCode的差值）。由于nextHashCode是类变量，所以每一次调用ThreadLocal类都可以保证nextHashCode被更新到新的值，并且下一次调用ThreadLocal类这个被更新的值仍然可用，同时AtomicInteger保证了nextHashCode自增的原子性。

### 内存泄漏问题
ThreadLocalMap使用ThreadLocal的弱引用作为key，如果一个ThreadLocal没有外部强引用引用他，那么系统gc的时候，这个ThreadLocal势必会被回收，这样一来，ThreadLocalMap中就会出现key为null的Entry，就没有办法访问这些key为null的Entry的value，如果当前线程再迟迟不结束的话，这些key为null的Entry的value就会一直存在一条强引用链：
Thread Ref -> Thread -> ThreaLocalMap -> Entry -> value
永远无法回收，造成内存泄露。

所以很多情况下需要使用者手动调用ThreadLocal的remove函数，手动删除不再需要的ThreadLocal，防止内存泄露。所以JDK建议将ThreadLocal变量定义成private static的，这样的话ThreadLocal的生命周期就更长，由于一直存在ThreadLocal的强引用，所以ThreadLocal也就不会被回收，也就能保证任何时候都能根据ThreadLocal的弱引用访问到Entry的value值，然后remove它，防止内存泄露。

### Netty源码中的FastThreadLocal
FastThreadLocal的内部Map维护的是一个数组，而JDK维护的是一个使用线性探测法的Map，可见，从底层数据结构上，他们的读取速度相差很大，特别是当数据量很大的时候，Netty的数据结构速度依然不变，而JDK由于使用线性探测法，速度会相应的下降。