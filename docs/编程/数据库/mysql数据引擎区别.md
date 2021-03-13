MyISAM:

myisam只支持表级锁，支持FULLTEXT类型的索引，myisam没有聚集索引，MyIsam 索引文件和数据文件是分离的，索引文件仅保存数据记录的地址。

InnoDB ：

Innodb支持支持外键、行锁、事务，InnoDB表数据文件本身就是按B+Tree组织的一个索引结构，这棵树的叶节点data域保存了完整的数据记录。