@echo off 
echo 1. ��ʼͬ��_sidebar.md
java -jar docsify-sidebar-generator.jar
echo 2. ��ʼ��ȡ
git pull
echo 3. ����ļ�
git add *
echo 4. �ύ
git commit -m 'sync'
echo 5. ����
git push