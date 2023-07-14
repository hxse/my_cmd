; 这个脚本是推galgame用的没,直接双击运行
MsgBox("按f自动滚动,再按f暂停滚动,e向上滚动,d向下滚动,z退出脚本")

e:: Send "{WheelUP}"
d:: Send "{WheelDown}"

flag := 0

f:: {
    global flag
    if (flag == 1) {
        flag := 0
    } else {
        flag := 1
    }
}

Loop
{
    if (flag == 1) {
        Send "{WheelDown}"
    }
    Sleep 400
}

z:: {
    ExitApp
}
