## @Transactional 使用





## 实现原理

1. 事务开始时，通过AOP机制，生成一个代理connection对象，并将其放入 DataSource 实例的某个与 DataSourceTransactionManager 相关的某处容器中。

   在接下来的整个事务中，客户代码都应该使用该 connection 连接数据库，执行所有数据库命令。[不使用该 connection 连接数据库执行的数据库命令，在本事务回滚的时候得不到回滚]（物理连接 connection 逻辑上新建一个会话session；DataSource 与 TransactionManager 配置相同的数据源）

2. 事务结束时，回滚在第1步骤中得到的代理 connection 对象上执行的数据库命令，然后关闭该代理 connection 对象。
   （事务结束后，回滚操作不会对已执行完毕的SQL操作命令起作用）

## 事务的传播机制

- PROPAGATION_REQUIRED
Spring默认的传播机制，能满足绝大部分业务需求，如果外层有事务，则当前事务加入到外层事务，一块提交，一块回滚。如果外层没有事务，新建一个事务执行
- PROPAGATION_REQUES_NEW
该事务传播机制是每次都会新开启一个事务，同时把外层事务挂起，当当前事务执行完毕，恢复上层事务的执行。如果外层没有事务，执行当前新开启的事务即可
- PROPAGATION_SUPPORT
如果外层有事务，则加入外层事务，如果外层没有事务，则直接使用非事务方式执行。完全依赖外层的事务
- PROPAGATION_NOT_SUPPORT
该传播机制不支持事务，如果外层存在事务则挂起，执行完当前代码，则恢复外层事务，无论是否异常都不会回滚当前的代码
- PROPAGATION_NEVER
该传播机制不支持外层事务，即如果外层有事务就抛出异常
- PROPAGATION_MANDATORY
与NEVER相反，如果外层没有事务，则抛出异常
- PROPAGATION_NESTED
该传播机制的特点是可以保存状态保存点，当前事务回滚到某一个点，从而避免所有的嵌套事务都回滚，即各自回滚各自的，如果子事务没有把异常吃掉，基本还是会引起全部回滚的。

