### List.toArray()

如果传入的数组长度大于集合长度，超出范围为null  
如果小于长度，生成一个传入数组运行时类型的新的数组
```java
public <T> T[] toArray(T[] a) {
        if (a.length < size)
            // Make a new array of a's runtime type, but my contents:
            return (T[]) Arrays.copyOf(elementData, size, a.getClass());
        System.arraycopy(elementData, 0, a, 0, size);
        if (a.length > size)
            a[size] = null;
        return a;
    }
```
