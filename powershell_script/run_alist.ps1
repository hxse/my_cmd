# 备份的方法是,复制 C:\Users\hxse\scoop\apps\alist\3.7.2\data\ 文件夹下的 config.json 和 datga.db
Set-PSDebug -Trace 1
alist server
Set-PSDebug -Trace 0
