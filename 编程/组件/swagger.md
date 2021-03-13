## Swagger使用

#### pom

```xml
<!-- swagger2核心依赖 -->
<dependency>
   <groupId>io.springfox</groupId>
   <artifactId>springfox-swagger2</artifactId>
   <version>2.6.1</version>
   <exclusions>
      <exclusion>
         <artifactId>jackson-annotations</artifactId>
         <groupId>com.fasterxml.jackson.core</groupId>
      </exclusion>
   </exclusions>
</dependency>

<!-- swagger-ui为项目提供api展示及测试的界面 -->
<dependency>
   <groupId>io.springfox</groupId>
   <artifactId>springfox-swagger-ui</artifactId>
   <version>2.6.1</version>
</dependency>
```

#### SwaggerConfig

```java
@Configuration
@EnableSwagger2
@EnableWebMvc
public class SwaggerConfig extends WebMvcConfigurerAdapter {

    @Value("${swagger.enabled}")
    private boolean swaggerEnable;

    @Bean
    public Docket api() {
        return new Docket(DocumentationType.SWAGGER_2)
            // 开关
                .enable(swaggerEnable)
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.xxx.web.controller"))
                .paths(PathSelectors.any())
                .build()
                .apiInfo(apiInfo());
    }
    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("后台管理系统")
                .description("后台管理系统服务端API接口文档")
                .version("1.0.0")
                .termsOfServiceUrl("")
                .license("")
                .licenseUrl("")
                .build();
    }

    // 继承WebMvcConfigurerAdapter，指定静态文件路径
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("swagger-ui.html")
                .addResourceLocations("classpath:/META-INF/resources/");

        registry.addResourceHandler("/webjars/**")
                .addResourceLocations("classpath:/META-INF/resources/webjars/");
    }
}
```