## Mysql锁
InnoDB支持行锁，加锁的方式：自动加锁。对于UPDATE、DELETE和INSERT语句，InnoDB会自动给涉及数据集加排他锁；对于普通SELECT语句，InnoDB不会加任何锁

InnoDB的行锁是针对索引加的锁，不是针对记录加的锁。

修改时如果索引