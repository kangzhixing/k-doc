```java
public class LeftRightDeadlock {
    private final Object left = new Object();
    private final Object right = new Object();

    public void leftRight() {
        // 得到left锁
        synchronized (left) {
            // 得到right锁
            synchronized (right) {
                doSomething();
            }
        }
    }

    public void rightLeft() {
        // 得到right锁
        synchronized (right) {
            // 得到left锁
            synchronized (left) {
                doSomethingElse();
            }
        }
    }
}
```