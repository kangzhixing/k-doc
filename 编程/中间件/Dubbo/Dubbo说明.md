## Dubbo内置了4种负载均衡策略:

### RandomLoadBalance:随机负载均衡。

随机的选择一个。是Dubbo的默认负载均衡策略。

### RoundRobinLoadBalance:轮询负载均衡。

轮询选择一个。

### LeastActiveLoadBalance:最少活跃调用数，相同活跃数的随机。

活跃数指调用前后计数差。使慢的 Provider 收到更少请求，因为越慢的 Provider 的调用前后计数差会越大。

### ConsistentHashLoadBalance:一致性哈希负载均衡。

相同参数的请求总是落在同一台机器上。

## Dubbo SPI机制
转：https://www.jianshu.com/p/7daa38fc9711

