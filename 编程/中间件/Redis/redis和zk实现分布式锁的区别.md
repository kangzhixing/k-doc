## Redis和Zookeeper实现分布式锁的区别
1.如果没获取到锁的情况下：
- redis分布式锁，其实需要自己不断去尝试获取锁，比较消耗性能
- zk分布式锁，获取不到锁，注册个监听器即可，不需要不断主动尝试获取锁，性能开销较小  

2.锁释放失败的情况下：
- redis获取锁的那个客户端bug了或者挂了，那么只能等待超时时间之后才能释放锁
- zk的话，因为创建的是临时znode，只要客户端挂了，znode就没了，此时就自动释放锁




#### ZK锁实现
在获取分布式锁的时候在locker节点下创建临时顺序节点，释放锁的时候删除该临时节点。客户端调用createNode方法在locker下创建临时顺序节点，

然后调用getChildren(“locker”)来获取locker下面的所有子节点，注意此时不用设置任何Watcher。客户端获取到所有的子节点path之后，如果发现自己在之

前创建的子节点序号最小，那么就认为该客户端获取到了锁。如果发现自己创建的节点并非locker所有子节点中最小的，说明自己还没有获取到锁，

此时客户端需要找到比自己小的那个节点，然后对其调用exist()方法，同时对其注册事件监听器。之后，让这个被关注的节点删除，则客户端的Watcher会

收到相应通知，此时再次判断自己创建的节点是否是locker子节点中序号最小的，如皋是则获取到了锁，如果不是则重复以上步骤继续获取到比自己小的一个

节点并注册监听。当前这个过程中还需要许多的逻辑判断。