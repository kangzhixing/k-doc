##  文本处理工具 - grep

### 参数

```
-E ：开启扩展（Extend）的正则表达式。

-i ：忽略大小写（ignore case）。

-v ：反过来（invert），只打印没有匹配的，而匹配的反而不打印。

-n ：显示行号

-w ：被匹配的文本只能是单词，而不能是单词中的某一部分，如文本中有liker，而我搜寻的只是like，就可以使用-w选项来避免匹配liker

-c ：显示总共有多少行被匹配到了，而不是显示被匹配到的内容，注意如果同时使用-cv选项是显示有多少行没有被匹配到。

-o ：只显示被模式匹配到的字符串。

--color :将匹配到的内容以颜色高亮显示。

-A  n：显示匹配到的字符串所在的行及其后n行，after

-B  n：显示匹配到的字符串所在的行及其前n行，before

-C  n：显示匹配到的字符串所在的行及其前后各n行，context
```

