; autohotkey /restart "D:\my_repo\my_cmd\ahk_script\run_minimize.ahk" "hidden" "C:\Users\hxse\scoop\apps\windows-terminal\1.15.3465.0\WindowsTerminal.exe" "run_clash" "alist" "webdav" "ftp" "subcovert" "SubConverter v0.7.1" "cat"
if A_Args.Length < 3
{

    MsgBox "脚本需要至少3个参数, 但它接收到 " A_Args.Length " 个" "`n" join(A_Args)
    ; ListVars
    ; Pause
    ExitApp
}
mode:=A_Args[1] ;可选项,show,hidden,exit,no,exit之后会自动恢复窗口,no表示什么也不做
path:=A_Args[2]
title:=A_Args[3]

titleArr := Array()
for k, v in A_Args
if(k>2){
    titleArr.Push v

}
; MsgBox "标题列表" join(titleArr)

join( strArray )
{
    s := ""
    for i,v in strArray
        s .= "`n" v
    return s
}

Persistent ; 阻止脚本自动退出.

if not FileExist(path){
    MsgBox "路径不存在,请输入绝对路径" path
    ExitApp
}

set_icon(path){
    fileinfo := Buffer(fisize := A_PtrSize + 688) ; 为 SHFILEINFOW 结构体申请内存.
    if DllCall("shell32\SHGetFileInfoW", "WStr", path
        , "UInt", 0, "Ptr", fileinfo, "UInt", fisize, "UInt", 0x100)
    {
        hicon := NumGet(fileinfo, 0, "Ptr")
        TraySetIcon "hicon:" hicon,,1
        ; 因为我们使用了 ":" 而不是 ":*", 在程序退出或菜单被删除时, 这些图标也会被自动释放.
    }
}
set_icon(path)

OnExit ExitFunc

ExitFunc(ExitReason, ExitCode)
{
    if ExitReason != "Reload" {
        ActivateWindows()
    }
}
loop_list(title,path,callback){
    DetectHiddenWindows 1
    ids := WinGetList(title)
    for this_id in ids
    {
        ; WinActivate this_id
        this_class := WinGetClass(this_id)
        this_title := WinGetTitle(this_id)
        this_pName:=WinGetProcessName(this_id)
        this_pPath:=WinGetProcessPath(this_id)
        if (this_title==title and this_pPath==path){
            callback(this_id,this_title,this_class,this_pPath,this_pName)
        }
    }
}
ActivateWindows(){
    Try {
        callback(this_id,this_title,this_class,this_pPath,this_pName){
            winShow this_id
            Sleep 100
            WinActivate this_id
        }
        for t in titleArr{
            loop_list(t,path,callback)
        }
    }
    catch Error as err {
        ; ListVars
        ; Pause
    } else {
    } finally {
    }
}
HiddenWindows(){
    Try
    {
        callback(this_id,this_title,this_class,this_pPath,this_pName){
            WinHide this_id
        }
        for t in titleArr{
            loop_list(t,path,callback)
        }
    }
    catch Error as err {
        ; ListVars
        ; Pause
    } else {
    } finally {
    }
}
switchFlag:=True
switchMenu(ItemName, ItemPos, MyMenu) {
    global switchFlag
    if(switchFlag){
        ActivateWindows()
        switchFlag:=!switchFlag
    }else{
        HiddenWindows()
        switchFlag:=!switchFlag
    }
}
activateMenu(ItemName, ItemPos, MyMenu) {
    ActivateWindows()
}
hiddenMenu(ItemName, ItemPos, MyMenu) {
    HiddenWindows()
}
exitMenu(ItemName, ItemPos, MyMenu) {
    ExitApp
}

A_TrayMenu.Delete()
A_TrayMenu.Add("switch", switchMenu)
A_TrayMenu.Add("activate", activateMenu)
A_TrayMenu.Add("hidden", hiddenMenu)
A_TrayMenu.Add("exit", exitMenu)
A_TrayMenu.Default := "switch"
A_TrayMenu.ClickCount:=1

mode_show(){
    ActivateWindows()
}
mode_hidden(){
    HiddenWindows()
}
if(mode=="show"){
    mode_show()
}
if(mode=="hidden"){
    mode_hidden()
}
if(mode=="exit"){
    ExitApp
}
if(mode=="no"){
}
