# Docsify - 快速搭建个人博客

## 什么是docsify

[docsify](https://github.com/docsifyjs/docsify)是GitHub上开源的快速搭建博客网站的项目

有别于Hexo等，docsify的特点是不需要将md文件转化成html，而是在运行时解析markdown文件渲染成html网页

**最关键的是: 它非常适合与GitHub Pages集成**

这是我通过docsify + GitHub Pages搭建的个人博客：https://kangzhixing.github.io/k-doc/

## 如何搭建

### 1. 安装docsify

   ```bash
   npm i docsify-cli -g
   ```

!> 注意：你需要先安装node

### 2. 初始化项目

   ```bash
   docsify init ./docs
   ```

   初始化完成后，目录下会出现docs文件夹，里面包含几个文件：

   - `index.html` 项目入口
   - `README.md` 会渲染成项目首页
   - `.nojekyll` docsify的文件多为下划线开头，这个文件可以使GitHub Pages 忽略掉这些下划线开头的文件

  当然，你也可以创建一个`index.html`文件，其中引用相关js文件并进行`window.$docsify`的配置即可
### 3. 本地运行
   ```bash
   docsify serve ./docs
   ```

   运行成功后，可以通过浏览器访问 [http://localhost:3000](http://localhost:3000)

## 功能介绍

### 1. 封面

通过设置`index.html`中window.$docsify的 `coverpage` 参数，可以为你的网站增加封面

```html
<script>
    window.$docsify = {
      coverpage: true
    }
</script>
```

然后在根目录下创建`_coverpage.md`文件，具体使用可参考[官方文档](https://docsify.js.org/#/zh-cn/cover)

### 2. 多页面侧边栏

通过设置`index.html`中的window.$docsify可以开启多页面侧边栏

```html
<script>
  window.$docsify = {
    loadSidebar: true
  }
</script>
```

docsify会寻找`_sidebar.md`文件，来渲染多个页面侧边栏，文件具体使用可参考[官方文档](https://docsify.js.org/#/zh-cn/more-pages)

#### 另：

[这里](https://github.com/kangzhixing/docsify-sidebar-generator)有一个小工具可以通过文件夹目录结构帮你快速生成`_sidebar.md`文件

>  将docsify-sidebar-generator.jar放到你的docsify根目录下
>
>  然后输入以下命令：
>
>  ```bash
>  java -jar .\docsify-sidebar.jar
>  ```

### 3. 主题

官方提供了五种主题，切换`index.html`中的css文件即可改变网站的主题风格

```html
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/vue.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/buble.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/dark.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/pure.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/themes/dolphin.css">
```

### 4. 全文搜索

在`index.html`中引用全文搜索的js文件，并配置`window.$docsify`
```html
<script>
  window.$docsify = {
    search: 'auto'
  }
</script>
<script src="//cdn.jsdelivr.net/npm/docsify/lib/plugins/search.min.js"></script>
```

配置完成后，网站左上角会出现一个搜索框，docsify会帮你在localstorage中建立索引

## 集成GitHub Pages

1. 将你的项目推送到GitHub仓库中

2. 在仓库setting中找到GitHub Pages的设置，提供两个选项：

   - 选择master分支，可以直接读取你的仓库根目录

   - 选择docs，可以读取你仓库里的docs文件夹

3. 设置完成后，页面会显示

   ```
   Your site is published at https://xxx.github.io/xxx
   ```

## 后记

现在，你就有了个人的在线博客了

你可以专注于文档书写，然后刷新`_sidebar.md`并推送到GitHub即可

附送一个window下将你的本地仓库自动同步GitHub的bat脚本

```bash
@echo off 
echo 1. 开始拉取
git pull
echo 2. 添加文件
git add *
echo 3. 提交
git commit -m 'sync'
echo 4. 推送
git push
```
