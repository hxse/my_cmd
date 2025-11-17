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
    netsh interface show interface
}
function dn {
    sudo netsh interface set interface $config.dn.name disable
}
function en {
    sudo netsh interface set interface $config.dn.name enable
}


Function nfp { netstat -aon | findstr $args[0] } #查找端口
Function tfp { tasklist | findstr $args[0] } #根据pid查找进程
Function tkp { taskkill /T /F /PID $args[0] } #根据pid结束进程
Function sd { Shutdown -s -t 30 }

function mip {
    $ytw = [regex]::Unescape("\u4ee5\u592a\u7f51")#以太网三个字的的unicode
    $ytw = "以太网"#只要是utf8 with bom, 就能输入中文了
    # $mip = Get-NetIPAddress |  where IPAddress -like '192.168.*' | where InterfaceAlias -like $ytw | select  -ExpandProperty "IPAddress"
    $mip = Get-NetIPAddress |  where { ($_.InterfaceAlias -like '以太网' -or $_.InterfaceAlias -like 'WLAN' ) } | where AddressFamily -like 'IPv4'  | Select-Object   "InterfaceAlias", "IPAddress"
    return $mip
}

Function gfh { Get-FileHash $args }

function osc {
    CMD.EXE /C "powershell (Add-Type '[DllImport(\`"user32.dll\`")]^public static extern int PostMessage(int hWnd, int hMsg, int wParam, int lParam);' -Name a -Pas)::PostMessage(-1, 0x0112, 0xF170, 2)"
}

function sd {
    $t = 60 * $args[0]
    echo "$t second"
    echo "Cancel Shutdown: shutdown /a or alias sa"
    shutdown -s -t $t
}
function sa {
    shutdown /a
}
