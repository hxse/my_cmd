# 修改tcp默认端口号起点,避免进程端口被占用,即使被占用了,也无法用 netstat -aon | findstr 查到哪个占用
# [遇到“OSError: \[WinError 10013\] 以一种访问权限不允许的方式做了一个访问套接字的尝试。”的解决方法。 · Issue #13552 · XX-net/XX-Net](https://github.com/XX-net/XX-Net/issues/13552)
# [windows tcp动态端口被占用过多，导致没有空闲的端口完成http请求。（发现很多TIME_WAIT状态的TCP连接） - 简书](https://www.jianshu.com/p/9ee0166aa01c)


Function nst {
    netsh int ipv4 show dynamicport tcp
    #netsh int ipv4 show dynamicport udp
}
Function nstp {
    netsh int ipv4 set dynamicport tcp start=49152 num=16384
    #netsh int ipv4 set dynamicport udp start=49152 num=16384
}

function sn {
    sudo netsh interface show interface
}
function dn {
    sudo netsh interface set interface $config.dn.name disable
}
function en {
    sudo netsh interface set interface $config.dn.name enable
}
Function py310 { . "C:\Users\hxse\scoop\apps\python310\current\python.exe" $args }
Function pip310 { . "C:\Users\hxse\scoop\apps\python310\current\python.exe" -m "pip" $args }
Function py37 { . "C:\Users\hxse\scoop\apps\python37\current\python.exe" $args }
Function pip37 { . "C:\Users\hxse\scoop\apps\python37\current\python.exe" -m "pip" $args }
Function py27 { . "C:\Users\hxse\scoop\apps\python27\current\python.exe" $args }
Function pip27 { . "C:\Users\hxse\scoop\apps\python27\current\python.exe" -m "pip" $args }


function g {
    # python terminal gui
    cd D:\my_repo\my_cmd\python_script;
    pdm run python .\prompt_toolkit_demo\mian.py $args
}
