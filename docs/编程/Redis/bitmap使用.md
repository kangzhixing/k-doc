## Bitmap使用

Bitmap在Redis中并不是一个单独的数据类型，而是由字符串类型（Redis内部称Simple Dynamic String，SDS）之上定义的与比特相关的操作实现的，此时SDS就被当做位数组了。

```
SETBIT key offset value
getbit key offset
```

在redis中，借助Bitmap可实现布隆过滤器。

