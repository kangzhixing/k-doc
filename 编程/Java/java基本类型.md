## 基本类型长度

类型 | byte | short | int | long | float | double | char | boolean
--- | --- | --- | --- | --- | --- | --- | --- | ---
字节数 | 1 | 2 | 4 | 8 | 4 | 8 | 2 | 1
取值范围 | ±27 | ±215 | ±231 | ±263 | ±231 | ±263 |  | true/false

## Integer的占用内存
4bytes是指向方法区里边Integer类信息的指针
4bytes是int的长度
4bytes是指向对象池的指针
一共12bytes