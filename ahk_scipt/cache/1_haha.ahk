pause
if A_Args.Length != 2
{
    MsgBox "脚本需要 2 个参数, 但它只接收到 " A_Args.Length " 个."
    ExitApp
}

title:=A_Args[1]
name:=A_Args[2]

if WinWait(title) {
	pName := WinGetProcessName(title)
	if (pName==name){
		WinActivate title
		Sleep 500
		WinHide ; 使用由 WinWait 找到的窗口.
		Sleep 1000
		WinShow ; 使用由 WinWait 找到的窗口.

		;Send "#+{F4}"
		;WinMinimize ; Use the window found by WinWait.
		
		;ListVars
		Pause
	}
	
}
