if A_Args.Length < 3
{
    MsgBox "脚本需要至少3个参数, 但它接收到 " A_Args.Length " 个" "`n" join(A_Args)
    ; ListVars
    ; Pause
    ExitApp
}

; title := "^powershell$"
; path := "^C:\\Users\\hxse\\scoop\\apps\\windows-terminal\\.*\\WindowsTerminal.exe$"
; waitTime := 60 ;最长等待时间
title := A_Args[1]
path := A_Args[2]
waitTime := A_Args[3]

; DetectHiddenWindows 1
SetTitleMatchMode "RegEx"

if WinWait(title, , waitTime) != 0 {
    this_id := WinGetTitle(title)  ; 正则匹配title
    this_class := WinGetClass(this_id)
    this_title := WinGetTitle(this_id)
    this_pName := WinGetProcessName(this_id)
    this_pPath := WinGetProcessPath(this_id)
    if RegExMatch(this_pPath, path) > 0 {
        ExitApp(1)
    }
}
MsgBox("`n" join(["未检测到窗口", title, path, waitTime]))
ExitApp(0)


join(strArray)
{
    s := ""
    for i, v in strArray
        s .= "`n" v
    return s
}
