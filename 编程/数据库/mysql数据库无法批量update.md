### mysql数据库无法批量update
connection链接字符串中设置参数`allowMultiQueries=true`
>jdbc:mysql://localhost:3306?<font color="red">allowMultiQueries=true</font>

官方解释：
```allowMultiQueries
Allow the use of ';' to delimit multiple queries during one statement (true/false), defaults to 'false', and does not affect the addBatch() and executeBatch() methods, which instead rely on rewriteBatchStatements.
Default: false
Since version: 3.1.1
```

