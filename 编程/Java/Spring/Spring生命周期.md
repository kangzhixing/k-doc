## Spring Bean生命周期
1. instantiate bean对象实例化 

   调用Bean的构造函数(或者工厂方法)实例化Bean

2. populate properties 封装属性
   对Bean的成员变量赋值，依赖注入

3. 如果Bean实现BeanNameAware执行setBeanName

4. 如果Bean实现BeanFactoryAware或ApplicationContextAware设置工厂setBeanFactory或上下文对象setApplicationContext

5. 如果存在类实现BeanPostProcessor(后处理Bean),执行postProcessBeforeInitialization

6. 如果Bean实现InitializingBean执行afterPropertiesSet

7. 调用自定义的init-method方法

8. 如果存在类实现BeanPostProcessor(处理Bean),执行postProcessAfterInitialization

9. 执行业务处理

10. 如果Bean实现DisposableBean执行destroy

11. 调用自定义的destroy-method


## Spring Mvc的生命周期
1. 客户端发出http请求，只要请求形式符合web.xml
文件中配置的*.action的话，就由DispatcherServlet
来处理。  
DispatcherServlet再将http请求委托给映射器的对象来将http请求交给对应的Action来处理
1. 映射器根据客户的http请求，再对比<bean name="/hello.action
如果匹配正确，再将http请求交给程序员写的Action
1. 执行Action中的业务方法，最终返回一个名叫ModelAndView的对象，其中封装了向视图发送的数据和视图的逻辑名
1. ModelAndView对象随着响应到到DispatcherServlet中了
1. 这时DispatcherServlet收到了ModelAndView对象，
它也不知道视图逻辑名是何意，又得委托一个名叫
视图解析器的对象去具体解析ModelAndView对象
中的内容

1. 将视图解析器解析后的内容，再次交由DispatcherServlet
核心控制器，这时核心控制器再将请求转发到具体的
视图页面，取出数据，再显示给用户

![image](https://img-blog.csdn.net/20131119111351875?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvYmlhb2h1X2xhbmg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)