## Netty
#### 优点：
- 封装JDK自带NIO的API
- 可靠性能力补齐
- 高性能，高吞吐量，低资源消耗


#### Netty的线程模型
Netty通过Reactor模型基于多路复用器接收并处理用户请求，内部实现了两个线程池，**boss线程池**和**work线程池**，其中boss线程池的线程负责处理请求的accept事件，当接收到accept事件的请求时，把对应的socket封装到一个NioSocketChannel中，并交给work线程池，其中work线程池负责请求的read和write事件，由对应的Handler处理。

