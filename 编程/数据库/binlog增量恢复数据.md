要确保我们有之前的备份，要已经了开启binlog日志
先手动切割出一份binlog让所有数据写到新的binlog上面
mysqladmin -uroot -p flush-log

拷贝离问题点最近的binlog日志
```
cp /application/mysql/data/mysql.00000x /tmp/
```

恢复最近一次备份
```
mysql -uroot -p he < /tmp/all_bak.sql
```

把binlog二进制文件导出成SQL语句
```
mysqlbinlog -d he /application/mysql/data/mysql.00000x >bin.sql
```
-d命令为只导出指定库的SQL语句

找出并删除错误语句  
vim bin.sql  
把出问题的sql语句删除掉

把修改好的数据导入
```
mysql -uroot -p oldboy <bin.sql
```