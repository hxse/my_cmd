;把脚本添加到开机启动,开机只会执行一次,也可以用脚本运行
;配合4T Tray使用,在4T里面设置快捷键最小化到托盘,从而隐藏掉windows terminal启动的脚本

title:="run_minimize"
pName:="WindowsTerminal.exe"
;WinWaitActive("ahk_exe WindowsTerminal.exe")and
if WinWait(title) {
	name := WinGetProcessName(title)
	if (name==pName){
	WinActivate title
	sleep 200
	Send "#+{F4}"
    ;WinMinimize ; Use the window found by WinWait.
    ;MsgBox name
    ;A_Clipboard := name
	}
	
}
