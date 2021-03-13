## 一、Java基础
1.JDK和JRE有什么区别？
JDK就是Java Development Kit 。JDK是面向开发人员使用的SDK，它提供了Java
的开发环境和运行环境。SDK是Software Development Kit 一般指软件开发包，
可以包括函数库、编译程序等。
JRE是Java Runtime Enviroment是指Java的运行环境，是面向Java程序的使用
者，而不是开发者。
2.== 和 equals 的区别是什么？
== 比较的是变量(栈)内存中存放的对象的(堆)内存地址，用来判断两个对象的
地址是否相同，即是否是指相同一个对象。比较的是真正意义上的指针操作。
a.比较的是操作符两端的操作数是否是同一个对象。
b.两边的操作数必须是同一类型的（可以是父子类之间）才能编译通过。
c.比较的是地址，如果是具体的阿拉伯数字的比较，值相等则为true，如：
int a=10 与 long b=10L 与 double c=10.0都是相同的（为true），因为他们
都指向地址为10的堆。
equals用来比较的是两个对象的内容是否相等，由于所有的类都是继承自
java.lang.Object类的，所以适用于所有对象，如果没有对该方法进行覆盖的
话，调用的仍然是Object类中的方法，而Object中的equals方法返回的却是==的
判断。
3.两个对象的 hashCode()相同，则 equals()也一定为 true，对吗？
两个obj，如果equals()相等，hashCode()一定相等。两个obj，如果hashCode()
相等，equals()不一定相等（Hash散列值有冲突的情况，虽然概率很低）。
https://www.cnblogs.com/jesonjason/p/5492208.html
4.final 在 java 中有什么作用？
final可以修饰类,函数,变量
修饰类时:意思是修饰类为最终类,任何类不能再继承它.
修改函数时:意思是该方法在类里是最终方法,继承它的方法不能去重写它.
修饰变量时:意思是被修饰的变量是常量或者叫终态变量,一旦初始化后就不能再
改变变量的值.
5.java 中的 Math.round(-1.5) 等于多少？
-1 知识点：Math.round()方法的使用
6.String 属于基础的数据类型吗？
不属于。String是一个对象。
8种基本数据类型： boolean byte char shrot int long float double
对应的基本类型包装类：Boolean Byte Character Short Integer Long Float
Double
7.java 中操作字符串都有哪些类？它们之间有什么区别？
查看源码 StringUtil即可。
8.String str="i"与 String str=new String("i")一样吗？
不一样。前者是一个常量，后者又重新new了一个对象，内存空间不一样。
9.如何将字符串反转？
new StringBuffer(s).reverse().toString();
10.String 类的常用方法都有那些？
11.抽象类必须要有抽象方法吗？
抽象类不一定要有抽象方法；但是有抽象方法的类一定是抽象类。
12.普通类和抽象类有哪些区别？
a.抽象类不能被实例化。
b.抽象类可以有构造函数，被继承时子类必须继承父类一个构造方法，抽象方法
不能被声明为静态。
c.抽象方法只需申明，而无需实现，抽象类中可以允许普通方法有主体
d.含有抽象方法的类必须申明为抽象类
e.抽象的子类必须实现抽象类中所有抽象方法，否则这个子类也是抽象类。
13.抽象类能使用 final 修饰吗？
final关键字不能用来抽象类和接口
14.接口和抽象类有什么区别？
a.抽象类和接口都不能直接实例化，如果要实例化，抽象类变量必须指向实现所
有抽象方法的子类对象，接口变量必须指向实现所有接口方法的类对象。
b.抽象类要被子类继承，接口要被类实现。
c.接口只能做方法申明，抽象类中可以做方法申明，也可以做方法实现
d.接口里定义的变量只能是公共的静态的常量，抽象类中的变量是普通变量。
e.抽象类里的抽象方法必须全部被子类所实现，如果子类不能全部实现父类抽象
方法，那么该子类只能是抽象类。同样，一个实现接口的时候，如不能全部实现
接口方法，那么该类也只能为抽象类。
f.抽象方法只能申明，不能实现，接口是设计的结果 ，抽象类是重构的结果
g.抽象类里可以没有抽象方法
h.如果一个类里有抽象方法，那么这个类只能是抽象类
i.抽象方法要被实现，所以不能是静态的，也不能是私有的。
j.接口可继承接口，并可多继承接口，但类只能单根继承。
15.java 中 IO 流分为几种？
https://www.cnblogs.com/QQ846300233/p/6046388.html
16.BIO、NIO、AIO 有什么区别？
https://blog.csdn.net/u010310183/article/details/81700405
17.Files的常用方法都有哪些？
https://www.cnblogs.com/cocoxu1992/p/10460994.html
18.intern()方法
当调用 intern 方法时，如果池已经包含一个等于此 String 对象的字符串（该
对象由 equals(Object) 方法确定），则返回池中的字符串。否则，将此
String 对象添加到池中，并且返回此 String 对象的引用。
## 二、容器
18.java 容器都有哪些？
19.Collection 和 Collections 有什么区别？
20.List、Set、Map 之间的区别是什么？
21.HashMap 和 Hashtable 有什么区别？
22.如何决定使用 HashMap 还是 TreeMap？
23.说一下 HashMap 的实现原理？
24.说一下 HashSet 的实现原理？
25.ArrayList 和 LinkedList 的区别是什么？

1. ArrayList的实现是基于数组，LinkedList的实现是基于双向链表。
2. 对于随机访问，ArrayList优于LinkedList
3. 对于插入和删除操作，LinkedList优于ArrayList
4. LinkedList比ArrayList更占内存，因为LinkedList的节点除了存储数据，还
存储了两个引用，一个指向前一个元素，一个指向后一个元素。
https://www.cnblogs.com/nnngu/p/8234568.html

26.如何实现数组和 List 之间的转换？
数组转list: Arrays.asList()
list转数组：list.toArray()
https://blog.csdn.net/andyzhaojianhui/article/details/49664553
27.ArrayList 和 Vector 的区别是什么？
https://blog.csdn.net/u011419651/article/details/83831156
28.Array 和 ArrayList 有何区别？
https://www.cnblogs.com/yonyong/p/9323546.html
29.在 Queue 中 poll()和 remove()有什么区别？
https://blog.csdn.net/qq_36101933/article/details/83145869
30.哪些集合类是线程安全的？
https://www.cnblogs.com/huangdabing/p/9249233.html
31.迭代器 Iterator 是什么？
32.Iterator 怎么使用？有什么特点？
33.Iterator 和 ListIterator 有什么区别？
https://www.cnblogs.com/xujian2014/p/5846128.html
34.怎么确保一个集合不能被修改？
https://blog.csdn.net/timchen525/article/details/80517517
## 三、多线程
35.并行和并发有什么区别？
并发:指应用能够交替执行不同的任务,其实并发有点类似于多线程的原理,多线
程并非是同时执行多个任务,如果你开两个线程执行,就是在你几乎不可能察觉到
的速度不断去切换这两个任务,已达到"同时执行效果",其实并不是的,只是计算
机的速度太快,我们无法察觉到而已.
就类似于你,吃一口饭喝一口水,以正常速度来看,完全能够看的出来,当你把这个
过程以n倍速度执行时..可以想象一下.
并行:指应用能够同时执行不同的任务,例:吃饭的时候可以边吃饭边打电话,这两
件事情可以同时执行
36.线程和进程的区别？
https://www.cnblogs.com/cocoxu1992/p/10468317.html
37.守护线程是什么？
守护线程（即daemon thread），是个服务线程，准确地来说就是服务其他的线
程，这是它的作用——而其他的线程只有一种，那就是用户线程。所以java里线
程分2种，
1、守护线程，比如垃圾回收线程，就是最典型的守护线程。
2、用户线程，就是应用程序里的自定义线程。
守护线程
1、守护线程，专门用于服务其他的线程，如果其他的线程（即用户自定义线
程）都执行完毕，连main线程也执行完毕，那么jvm就会退出（即停止运行）
——此时，连jvm都停止运行了，守护线程当然也就停止执行了。
2、再换一种说法，如果有用户自定义线程存在的话，jvm就不会退出——此时，
守护线程也不能退出，也就是它还要运行，干嘛呢，就是为了执行垃圾回收的任
务啊。
用户自定义线程
1、应用程序里的线程，一般都是用户自定义线程。
2、用户也可以在应用程序代码自定义守护线程，只需要调用Thread类的设置方
法设置一下即可。
38.创建线程有哪几种方式？
39.说一下 runnable 和 callable 有什么区别？
40.线程有哪些状态？
41.sleep() 和 wait() 有什么区别？
42.notify()和 notifyAll()有什么区别？
43.线程的 run()和 start()有什么区别？
44.创建线程池有哪几种方式？
45.线程池都有哪些状态？
46.线程池中 submit()和 execute()方法有什么区别？
47.在 java 程序中怎么保证多线程的运行安全？
48.多线程锁的升级原理是什么？
49.什么是死锁？
　　死锁是指多个进程因竞争资源而造成的一种僵局（互相等待），若无外力作
用，这些进程都将无法向前推进。例如，在某一个计算机系统中只有一台打印机
和一台输入 设备，进程P1正占用输入设备，同时又提出使用打印机的请求，但
此时打印机正被进程P2 所占用，而P2在未释放打印机之前，又提出请求使用正
被P1占用着的输入设备。这样两个进程相互无休止地等待下去，均无法继续执
行，此时两个进程陷入死锁状态。
死锁产生的原因：

1. 系统资源的竞争 ：系统资源的竞争导致系统资源不足，以及资源分配不
  当，导致死锁。

进程运行推进顺序不合适：进程在运行过程中，请求和释放资源的顺序不
当，会导致死锁。
50.怎么防止死锁？
https://www.cnblogs.com/bopo/p/9228834.html
51.ThreadLocal 是什么？有哪些使用场景？
https://www.cnblogs.com/chenkeyu/p/7623653.html
52.说一下 synchronized 底层实现原理？
https://www.cnblogs.com/paddix/p/5367116.html
53.synchronized 和 volatile 的区别是什么？
https://www.cnblogs.com/ouyxy/p/7242563.html
54.synchronized 和 Lock 有什么区别？
55.synchronized 和 ReentrantLock 区别是什么？
56.说一下 atomic 的原理？
https://blog.csdn.net/weixin_41846500/article/details/86636498
## 四、反射
57.什么是反射？
58.什么是 java 序列化？什么情况下需要序列化？
59.动态代理是什么？有哪些应用？
60.怎么实现动态代理？
## 五、对象拷贝
61.为什么要使用克隆？
62.如何实现对象克隆？
63.深拷贝和浅拷贝区别是什么？
## 六、Java Web
64.jsp 和 servlet 有什么区别？
65.jsp 有哪些内置对象？作用分别是什么？
66.说一下 jsp 的 4 种作用域？
67.session 和 cookie 有什么区别？
68.说一下 session 的工作原理？
69.如果客户端禁止 cookie 能实现 session 还能用吗？
70.spring mvc 和 struts 的区别是什么？
71.如何避免 sql 注入？
72.什么是 XSS 攻击，如何避免？
73.什么是 CSRF 攻击，如何避免？

## 七、异常
74.throw 和 throws 的区别？
a.throws出现在方法函数头；而throw出现在函数体。
b.throws表示出现异常的一种可能性，并不一定会发生这些异常；throw则是抛
出了异常，执行throw则一定抛出了某种异常对象。
c.两者都是消极处理异常的方式（这里的消极并不是说这种方式不好），只是抛
出或者可能抛出异常，但是不会由函数去处理异常，真正的处理异常由函数的上
层调用处理。
75.final、finally、finalize 有什么区别？
a.final修饰符（关键字）。被final修饰的类，就意味着不能再派生出新的子
类，不能作为父类而被子类继承。因此一个类不能既被abstract声明，又被
final声明。将变量或方法声明为final，可以保证他们在使用的过程中不被修
改。被声明为final的变量必须在声明时给出变量的初始值，而在以后的引用中
只能读取。被final声明的方法也同样只能使用，即不能方法重写。
b.finally是在异常处理时提供finally块来执行任何清除操作。不管有没有异常
被抛出、捕获，finally块都会被执行。try块中的内容是在无异常时执行到结
束。catch块中的内容，是在try块内容发生catch所声明的异常时，跳转到catch
块中执行。finally块则是无论异常是否发生，都会执行finally块的内容，所以
在代码逻辑中有需要无论发生什么都必须执行的代码，就可以放在finally块
中。
c.finalize是方法名。java技术允许使用finalize()方法在垃圾收集器将对象从
内存中清除出去之前做必要的清理工作。这个方法是由垃圾收集器在确定这个对
象没有被引用时对这个对象调用的。它是在object类中定义的，因此所有的类都
继承了它。子类覆盖finalize()方法以整理系统资源或者被执行其他清理工作。
finalize()方法是在垃圾收集器删除对象之前对这个对象调用的。
76.try-catch-finally 中哪个部分可以省略？
catch部分可以省略，也可以有多个。
77.try-catch-finally 中，如果 catch 中 return 了，finally 还会执行
吗？
会，finally语句块一定会执行。
78.常见的异常类有哪些？
省略……
## 八、网络
79.http 响应码 301 和 302 代表的是什么？有什么区别？
80.forward 和 redirect 的区别？
81.简述 tcp 和 udp的区别？
82.tcp 为什么要三次握手，两次不行吗？为什么？
83.说一下 tcp 粘包是怎么产生的？
84.OSI 的七层模型都有哪些？
85.get 和 post 请求有哪些区别？
86.如何实现跨域？
87.说一下 JSONP 实现原理？
## 九、设计模式
88.说一下你熟悉的设计模式？
89.简单工厂和抽象工厂有什么区别？

## 十、Spring/Spring MVC
90.为什么要使用 spring？
91.解释一下什么是 aop？
92.解释一下什么是 ioc？
93.spring 有哪些主要模块？
94.spring 常用的注入方式有哪些？
95.spring 中的 bean 是线程安全的吗？
96.spring 支持几种 bean 的作用域？
97.spring 自动装配 bean 有哪些方式？
98.spring 事务实现方式有哪些？
99.说一下 spring 的事务隔离？
100.说一下 spring mvc 运行流程？
101.spring mvc 有哪些组件？
102.@RequestMapping 的作用是什么？
103.@Autowired 的作用是什么？

## 十一、Spring Boot/Spring Cloud
104.什么是 spring boot？
105.为什么要用 spring boot？
106.spring boot 核心配置文件是什么？
107.spring boot 配置文件有哪几种类型？它们有什么区别？
108.spring boot 有哪些方式可以实现热部署？
109.jpa 和 hibernate 有什么区别？
110.什么是 spring cloud？
111.spring cloud 断路器的作用是什么？
112.spring cloud 的核心组件有哪些？
## 十二、Hibernate
113.为什么要使用 hibernate？
114.什么是 ORM 框架？
115.hibernate 中如何在控制台查看打印的 sql 语句？
116.hibernate 有几种查询方式？
117.hibernate 实体类可以被定义为 final 吗？
118.在 hibernate 中使用 Integer 和 int 做映射有什么区别？
119.hibernate 是如何工作的？
120.get()和 load()的区别？
121.说一下 hibernate 的缓存机制？
122.hibernate 对象有哪些状态？
123.在 hibernate 中 getCurrentSession 和 openSession 的区别是什么？
124.hibernate 实体类必须要有无参构造函数吗？为什么？
## 十三、Mybatis
125.mybatis 中 #{}和 ${}的区别是什么？
126.mybatis 有几种分页方式？
127.RowBounds 是一次性查询全部结果吗？为什么？
128.mybatis 逻辑分页和物理分页的区别是什么？
129.mybatis 是否支持延迟加载？延迟加载的原理是什么？
130.说一下 mybatis 的一级缓存和二级缓存？
https://www.cnblogs.com/yuluoxingkong/p/8205858.html
131.mybatis 和 hibernate 的区别有哪些？
132.mybatis 有哪些执行器（Executor）？
133.mybatis 分页插件的实现原理是什么？
134.mybatis 如何编写一个自定义插件？
## 十四、RabbitMQ
135.rabbitmq 的使用场景有哪些？
136.rabbitmq 有哪些重要的角色？
137.rabbitmq 有哪些重要的组件？
138.rabbitmq 中 vhost 的作用是什么？
139.rabbitmq 的消息是怎么发送的？
140.rabbitmq 怎么保证消息的稳定性？
141.rabbitmq 怎么避免消息丢失？
142.要保证消息持久化成功的条件有哪些？
143.rabbitmq 持久化有什么缺点？
144.rabbitmq 有几种广播类型？
145.rabbitmq 怎么实现延迟消息队列？
146.rabbitmq 集群有什么用？
147.rabbitmq 节点的类型有哪些？
148.rabbitmq 集群搭建需要注意哪些问题？
149.rabbitmq 每个节点是其他节点的完整拷贝吗？为什么？
150.rabbitmq 集群中唯一一个磁盘节点崩溃了会发生什么情况？
151.rabbitmq 对集群节点停止顺序有要求吗？
## 十五、Kafka
152.kafka 可以脱离 zookeeper 单独使用吗？为什么？
153.kafka 有几种数据保留的策略？
154.kafka 同时设置了 7 天和 10G 清除数据，到第五天的时候消息达到了
10G，这个时候 kafka 将如何处理？
155.什么情况会导致 kafka 运行变慢？
156.使用 kafka 集群需要注意什么？
## 十六、Zookeeper
157.zookeeper 是什么？
158.zookeeper 都有哪些功能？
159.zookeeper 有几种部署模式？
160.zookeeper 怎么保证主从节点的状态同步？
161.集群中为什么要有主节点？
162.集群中有 3 台服务器，其中一个节点宕机，这个时候 zookeeper 还可以使
用吗？
163.说一下 zookeeper 的通知机制？
## 十七、MySql
164.数据库的三范式是什么？
165.一张自增表里面总共有 7 条数据，删除了最后 2 条数据，重启 mysql 数
据库，又插入了一条数据，此时 id 是几？
166.如何获取当前数据库版本？
167.说一下 ACID 是什么？
168.char 和 varchar 的区别是什么？
169.float 和 double 的区别是什么？
170.mysql 的内连接、左连接、右连接有什么区别？
171.mysql 索引是怎么实现的？
172.怎么验证 mysql 的索引是否满足需求？
173.说一下数据库的事务隔离？
174.说一下 mysql 常用的引擎？
175.说一下 mysql 的行锁和表锁？
176.说一下乐观锁和悲观锁？
177.mysql 问题排查都有哪些手段？
178.如何做 mysql 的性能优化？
## 十八、Redis
179.redis 是什么？都有哪些使用场景？
180.redis 有哪些功能？
181.redis 和 memecache 有什么区别？
182.redis 为什么是单线程的？
183.什么是缓存穿透？怎么解决？
184.redis 支持的数据类型有哪些？
185.redis 支持的 java 客户端都有哪些？
186.jedis 和 redisson 有哪些区别？
187.怎么保证缓存和数据库数据的一致性？
188.redis 持久化有几种方式？
189.redis 怎么实现分布式锁？
190.redis 分布式锁有什么缺陷？
191.redis 如何做内存优化？
192.redis 淘汰策略有哪些？
193.redis 常见的性能问题有哪些？该如何解决？
## 十九、JVM
194.说一下 jvm 的主要组成部分？及其作用？
195.说一下 jvm 运行时数据区？
196.说一下堆栈的区别？
197.队列和栈是什么？有什么区别？
198.什么是双亲委派模型？
199.说一下类加载的执行过程？
200.怎么判断对象是否可以被回收？
201.java 中都有哪些引用类型？
202.说一下 jvm 有哪些垃圾回收算法？
203.说一下 jvm 有哪些垃圾回收器？
204.详细介绍一下 CMS 垃圾回收器？
205.新生代垃圾回收器和老生代垃圾回收器都有哪些？有什么区别？
206.简述分代垃圾回收器是怎么工作的？
207.说一下 jvm 调优的工具？
208.常用的 jvm 调优的参数都有哪些？