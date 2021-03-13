@echo off 
echo 1. 开始拉取
git pull
echo 2. 添加文件
git add *
echo 3. 提交
git commit -m 'sync'
echo 4. 推送
git push