### 如果确定该类不能被实例化，应当在私有构造方法中，增加AssertionError

```java
throw new AssertionError("No java.util.Objects instances for you!");
```

Java反射可以修改方法的访问权限，如果不抛出错误，使用Constructor.newInstance()方法仍可以实例化。

```java
public class ClassPrivate {
    @Test
    public void test() {
        try {
            Class<?> clazz = Class.forName("java.util.Objects");
            Constructor<?> constructor = clazz.getDeclaredConstructor();// 获取构造方法
            constructor.setAccessible(true); // 修改private权限。true表示可以访问私有方法
            Objects objects = (Objects) constructor.newInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```