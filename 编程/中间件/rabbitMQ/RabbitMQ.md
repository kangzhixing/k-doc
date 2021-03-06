# RabbitMq

## AMQP概念
AMQP（Advanced Message Queuing Protocol，高级消息队列协议）是一个进程间传递异步消息的网络协议。

## AMQP模型
工作过程
发布者（Publisher）发布消息（Message），经由交换机（Exchange）。

交换机根据**路由规则**将收到的消息分发给与该交换机绑定的队列（Queue）。

最后 AMQP 代理会将消息投递给订阅了此队列的消费者，或者消费者按照需求自行获取。

## 四种交换机
1) Default Exchange
这种是特殊的Direct Exchange，是rabbitmq内部默认的一个交换机。该交换机的name是空字符串，所有queue都默认binding 到该交换机上。所有binding到该交换机上的queue，routing-key都和queue的name一样。  
**注意：** 直接创建一个queue也能正常的生产与消费，因为对应的exchange是RabbitMQ默认的，routingkey就是该队列的名字。

1) Topic Exchange
通配符交换机，exchange会把消息发送到一个或者多个满足通配符规则的routing-key的queue。其中表号匹配一个word，#匹配多个word和路径，路径之间通过.隔开。如满足a..c的routing-key有a.hello.c；满足#.hello的routing-key有a.b.c.helo。

1) Fanout Exchange
扇形交换机，该交换机会把消息发送到所有binding到该交换机上的queue。这种是publisher/subcribe模式。用来做广播最好。
所有该exchagne上指定的routing-key都会被ignore掉。

1) Header Exchange
设置header attribute参数类型的交换机。

#### 消息的读写及删除：

rabbitmq在启动时会创建两个进程：
- msg_store_persistent  
- msg_store_transient

一个用于持久消息的存储，一个用于内存不够时，将存储在内存中的非持久化数据转存到磁盘中。所有队列的消息的写入和删除最终都由这两个进程负责处理，而消息的读取则可能是队列本身直接打开文件进行读取，也可能是发送请求由msg_store_persisteng/msg_store_transient进程进行处理。

在进行消息的存储时，rabbitmq会在ets表中记录消息在文件中的映射，以及文件的相关信息。消息读取时，根据消息ID找到该消息所存储的文件，在文件中的偏移量，然后打开文件进行读取。消息的删除只是从ets表删除指定消息的相关信息，同时更新消息对应存储的文件的相关信息（更新文件有效数据大小）。

## 事务开启方式

1. 通过channel

2. autoAck=false开启ack确认机制

## 死信队列
在队列加上一个参数即可：arguments.put(" x-dead-letter-exchange"，"dlx.exchange");，这样消息在过期、requeue、 队列在达到最大长度时，消息就可以直接路由到死信队列

### 过期消息

在 rabbitmq 中存在2种方可设置消息的过期时间，第一种通过对队列进行设置，这种设置后，该队列中所有的消息都存在相同的过期时间，第二种通过对消息本身进行设置，那么每条消息的过期时间都不一样。如果同时使用这2种方法，那么以过期时间小的那个数值为准。当消息达到过期时间还没有被消费，那么那个消息就成为了一个 死信 消息。

队列设置：在队列申明的时候使用 x-message-ttl 参数，单位为 毫秒

单个消息设置：是设置消息属性的 expiration 参数的值，单位为 毫秒