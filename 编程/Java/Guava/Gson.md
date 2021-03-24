## Gson的使用

### 1. GitHub

[gson on GitHub](https://github.com/google/gson "GitHub")


### 2. pom

```xml
<!-- https://mvnrepository.com/artifact/com.google.code.gson/gson -->
<dependency>
    <groupId>com.google.code.gson</groupId>
    <artifactId>gson</artifactId>
    <version>2.8.6</version>
</dependency>

```

### 3. GsonUtil

```java
import com.google.gson.*;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.text.DateFormat;
import java.util.*;

/**
 * 封装Gson常用方法工具类
 */
public class JsonUtils {
    /**
     * 不用创建对象,直接使用Gson.就可以调用方法
     */
    private static Gson GSON;

    private static JsonParser JSON_PARSER = new JsonParser();

    /**
     * 私有无参构造方法
     */
    private JsonUtils() {
    }

    //创建Gson
    static {
        if (GSON == null) {
            GSON = new Gson();
        }
    }

    /**
     * 将对象转成json格式
     *
     * @param object 入参为对象
     * @return String 出参为转换后的字符串
     */
    public static String toJSONString(Object object) {
        try {
            return GSON.toJson(object);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 将json转成特定的cls的对象
     *
     * @param jsonString json串
     * @param cls        class对象
     * @param <T>        对象类型
     * @return 特定对象
     */
    public static <T> T toJavaObject(String jsonString, Class<T> cls) {
        try {
            return GSON.fromJson(jsonString, cls);
        } catch (Exception e) {
        	return null;
        }
    }

    /**
     * 将json转成特定的type的对象
     *
     * @param jsonString json串
     * @param type       type
     * @param <T>        对象类型
     * @return 特定对象
     */
    public static <T> T toJavaObject(String jsonString, Type type) {
        try {
            return GSON.fromJson(jsonString, type);
        } catch (Exception e) {
        	return null;
        }
    }

    // 比toJavaObject(String, JsonObject.class)快，耗时约为后者为2/5
    /**
     * 将json转成JsonElement对象
     *
     * @param jsonString json串
     * @return 特定对象
     */
    public static JsonElement toJsonElement(String jsonString) {
        try {
            return JSON_PARSER.parse(jsonString);
        } catch (Exception e) {
            return null;
        }
    }
}
```



### 4. PrettyFormat

实例化Gson对象时，调用setPrettyPrinting()方法

```java
Gson gson = new GsonBuilder().setPrettyPrinting().create();
```

