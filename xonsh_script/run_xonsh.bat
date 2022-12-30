::pip install xonsh
::scoop install git
::把下面路径添加到环境变量,就可以在cmd使用linux命令了 C:\Users\hxse\scoop\apps\git\2.36.1.windows.1\usr\bin
::点击.xsh后缀文件,然后选择打开方式,用本脚本打开即可
@echo on
xonsh %1

@echo off
echo ------ echo command history ------
echo cat "%1"
echo cat r"%1"
echo xonsh "%1"
echo xonsh r"%1"
echo ------ end  command history ------
xonsh

