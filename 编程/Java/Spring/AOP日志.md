## 1. 为切面提供注解

```java
/**
 * 打印日志
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.TYPE})
public @interface OpenLog {

    /**
     * 方法说明
     */
    String value() default "";
}
```



PS：另外提供@NoLogRequest和@NoLogResponse选择隐藏日志中的参数

## 2. 切面日志工具类

```java
/**
 * 日志工具类
 */
@Slf4j
public class OlLog {

    /**
     * 通过ProceedingJoinPoint获取方法
     */
    public static Method getMethodByProceedingJoinPoint(ProceedingJoinPoint proceedingJoinPoint) {
        try {
            MethodSignature ms = (MethodSignature) proceedingJoinPoint.getSignature();
            return proceedingJoinPoint.getTarget().getClass().getDeclaredMethod(ms.getName(), ms.getParameterTypes());
        } catch (NoSuchMethodException e) {
            return null;
        }
    }

    /**
     * 通过ProceedingJoinPoint生成日志标题
     */
    public static String getLogTitle(ProceedingJoinPoint proceedingJoinPoint) {
        try {
            String apiInfomation = "";
            // 获取方法
            Method targetMethod = getMethodByProceedingJoinPoint(proceedingJoinPoint);
            if (targetMethod == null) {
                return "";
            }

            // 优先输出swagger注释
            ApiOperation annotationApi = targetMethod.getAnnotation(ApiOperation.class);
            if (annotationApi != null && annotationApi.value().length() > 0) {
                apiInfomation += "[" + annotationApi.value() + "]";
            } else {
                OpenLog annotationOpenLog = targetMethod.getAnnotation(OpenLog.class);
                if (annotationOpenLog != null && annotationOpenLog.value().length() > 0) {
                    apiInfomation += "[" + annotationOpenLog.value() + "]";
                }
            }
            return String.format("%s[%s.%s]", apiInfomation, targetMethod.getDeclaringClass().getSimpleName(),
                    targetMethod.getName());
        } catch (Exception ex) {
            return "";
        }
    }


    /**
     * 打印请求
     */
    public static void logRequest(ProceedingJoinPoint proceedingJoinPoint) {
        try {
            String methodTitle = getLogTitle(proceedingJoinPoint);

            Method targetMethod = getMethodByProceedingJoinPoint(proceedingJoinPoint);
            // 打印请求
            NoLogRequest annotationNoReq = targetMethod.getDeclaredAnnotation(NoLogRequest.class);
            if (annotationNoReq != null) {
                log.info("[REQUEST]{}", methodTitle);
            } else {
                log.info("[REQUEST]{} param: {}", methodTitle, OlString.argsFormat(proceedingJoinPoint.getArgs()));
            }

        } catch (Exception ex) {
            log.error("日志打印失败", ex);
        }
    }

    /**
     * 打印返回
     *
     * @param proceedingJoinPoint
     * @param result 请求结果
     * @param start 请求时间戳
     */
    public static void logResponse(ProceedingJoinPoint proceedingJoinPoint, Object result, long start) {
        try {
            String methodTitle = getLogTitle(proceedingJoinPoint);

            Method targetMethod = getMethodByProceedingJoinPoint(proceedingJoinPoint);
            // 打印返回
            NoLogResponse annotationNoResp = targetMethod.getDeclaredAnnotation(NoLogResponse.class);
            if (annotationNoResp != null) {
                log.info("[RESPONSE]{}[{}ms]", methodTitle, System.currentTimeMillis() - start);
            } else {
                log.info("[RESPONSE]{}[{}ms] return: " + OlString.argsFormat(result), methodTitle, (System.currentTimeMillis() - start) + "");
            }

        } catch (Exception ex) {
            log.error("日志打印失败", ex);
        }
    }
}
```



## 3. AOP切面

```java
@Aspect
@Component
@Slf4j
public class LogFacadeAspect {

	/**
 	 * 所有facade接口下的方法
 	 * 可通过@NoLog注解排除
 	 */
    @Pointcut("execution(public * com.xxx.xxx.provider.facade..*.*(..)) || @annotation(com.jd.jr.open.annotation.NoLog)")
    private void logFacade() {
    }

	/**
 	 * 切面@OpenLog注解
 	 */
    @Pointcut("@annotation(com.xxx.xxx.annotation.OpenLog)")
    private void logAnnotation() {
    }

    @Around("logFacade() || logAnnotation()")
    public Object doAround(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {

        // 打印请求
        OlLog.logRequest(proceedingJoinPoint);

        // 执行请求
        long start = System.currentTimeMillis();
        Object result = proceedingJoinPoint.proceed();

        // 打印返回
        OlLog.logResponse(proceedingJoinPoint, result, start);
        return result;
    }

	/**
	 * 异常处理
	 */
    @AfterThrowing(throwing = "ex", pointcut = "logFacade() || logAnnotation()")
    public void catchEx(Throwable ex) {
        log.error("[内部错误]", ex);
    }

}
```



## 4. 使用

```java
@OpenLog("添加待办")
public GeneralResponse<Boolean> addTodoTask(TodoTaskAddRequest todoTaskAddRequest) {
	// TODO	...
}
```