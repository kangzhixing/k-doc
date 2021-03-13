## Redis支持五种数据类型：
#### String（字符串）
set key value
get key
底层是SDS（Simple Dynamic String），以字符数组储存，也记录了长度，所以属于二进制安全。
#### Hash（哈希）
hset key field value
hget key field
#### List（列表）
lpush key value[value...]
lpop key(移除并返回key对应的第一个元素)
#### Set（集合）
sadd key value[value...]
#### Zset(sorted set：有序集合)。
zadd key score value[[score value]...]