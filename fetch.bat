@echo off 
echo 1. 开始同步_sidebar.md
java -jar docsify-sidebar-generator.jar
echo 2. 开始拉取
git pull
echo 3. 添加文件
git add *
echo 4. 提交
git commit -m 'sync'
echo 5. 推送
git push