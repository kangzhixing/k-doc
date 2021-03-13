## HashMap
#### 扩容
当HashMap中的元素个数超过数组大小(数组总大小length,不是数组中个数size)*loadFactor时，就会进行数组扩容

链表长度大于8或者数组长度小于64时转为红黑树

#### 扩容为什么是2的幂次方
因为在计算元素该存放的位置的时候，用到的算法是将元素的hashcode与当前map长度-1进行与运算。源码：
```java
static int indexFor(int h, int length) {
    // assert Integer.bitCount(length) == 1 : "length must be a non-zero power of 2";
    return h & (length-1);
}
```
如果map长度为2的幂次，那长度-1的二进制一定为11111...这种形式，进行与运算就看元素的hashcode，但是如果map的长度不是2的幂次，比如为15，那长度-1就是14，二进制为1110，无论与谁相与最后一位一定是0，0001，0011，0101，1001，1011，0111，1101这几个位置就永远都不能存放元素了，空间浪费相当大。也增加了添加元素是发生碰撞的机会。减慢了查询效率。所以Hashmap的大小是2的幂次。

#### 高并发下容易死循环的问题
1. put的时候导致的多线程数据不一致  
比如有两个线程A和B，首先A希望插入一个key-value对到HashMap中，首先计算记录所要落到的 hash桶的索引坐标，然后获取到该桶里面的链表头结点，此时线程A的时间片用完了，而此时线程B被调度得以执行，和线程A一样执行，只不过线程B成功将记录插到了桶里面，假设线程A插入的记录计算出来的 hash桶索引和线程B要插入的记录计算出来的 hash桶索引是一样的，那么当线程B成功插入之后，线程A再次被调度运行时，它依然持有过期的链表头但是它对此一无所知，以至于它认为它应该这样做，如此一来就覆盖了线程B插入的记录，这样线程B插入的记录就凭空消失了，造成了数据不一致的行为。
1.  resize而引起死循环（JDK1.8已经不会出现该问题）  
HashMap 扩容的时候会调用resize()方法，其内部又会调用transfer()方法，而这种方法实现的机制就是将每一个链表转化到新链表，而且链表中的位置发生反转，因此极易造成链表回路，形成环形链表，打满CPU。

#### 例
```java
final HashMap<String, String> map = new HashMap<String, String>(2);
for (int i = 0; i < 10000; i++) {
    new Thread(new Runnable() {
        @Override
        public void run() {
            map.put(UUID.randomUUID().toString(), "");
        }
    }).start();
}
```

#### HashTable安全但效率低下
HashTable容器使用synchronized来保证线程安全，所以当一个线程访问HashTable的同步方法时，其他线程访问HashTable的同步方法时，可能会进入阻塞或轮询状态。

#### ConcurrentHashMap分段锁说明
ConcurrentHashMap里包含一个Segment数组（Segment是一种可重入锁ReentrantLock），Segment的结构和HashMap类似，是一种数组和链表结构，一个Segment里包含一个HashEntry数组，每个HashEntry是一个链表结构的元素，每个Segment守护着一个HashEntry数组里的元素,当对HashEntry数组的数据进行修改时，必须首先获得它对应的Segment锁。  
JDK1.8以后，摒弃Segment，采用“数组”+链表+红黑树的方式，使用unsafe.compareAndSwapXXX和Syncronized保证线程安全。  
HashEntry中的value以及next都被volatile修饰，这样在多线程读写过程中能够保持它们的可见性。

## LinkedHashMap
LinkedHashMap内部维护了Entry[]的同时，还维护了一个双向链表。  
从遍历的效率来说，遍历双向链表的效率要高于遍历table，因为遍历双向链表是N次（N为元素个数）；而遍历table是N+table的空余个数（N为元素个数）。LinkedHashMap是继承于HashMap，是基于HashMap和双向链表来实现的。  
HashMap无序；LinkedHashMap有序，可分为插入顺序和访问顺序两种。如果是访问顺序，那put和get操作已存在的Entry时，都会把Entry移动到双向链表的表尾(其实是先删除再插入)。  
LinkedHashMap存取数据，还是跟HashMap一样使用的Entry[]的方式，双向链表只是为了保证顺序。  
LinkedHashMap是线程不安全的。

### 储存顺序
LinkedHashMap的空构造方法如下：
```java
public LinkedHashMap() {
    // 调用HashMap的构造方法，其实就是初始化Entry[] table
    super();
    // 这里是指是否基于访问排序，默认为false
    accessOrder = false;
}
```

其中accessOrder的值，false代表插入顺序，true代表访问顺序。

例如：
使用构造方法
```java
new LinkedHashMap<>(16, 0.75f, true)
```
当accessOrder=true时，get访问的元素，会存放到队尾。