; 举例 autohotkey /restart  .\run.ahk "run_clash" "C:\Users\hxse\scoop\apps\windows-terminal\current\WindowsTerminal.exe" hidden
if A_Args.Length == 3
{
    title:=A_Args[1]
    path:=A_Args[2]
    mode:=A_Args[3] ;可选项,show,hidden,exit,exit之后会自动恢复窗口
}else if (A_Args.Length==2){
    title:=A_Args[1]
    path:=A_Args[2]
    mode:=""
}else{
    MsgBox "脚本需要 2,3 个参数, 但它接收到 " A_Args.Length " 个" "`n" join(A_Args)
    ; ListVars
    ; Pause
    ExitApp
}

join( strArray )
{
    s := ""
    for i,v in strArray
        s .= "`n" v
    return substr(s, 3)
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
        loop_list(title,path,callback)
    }
    catch Error as err {
        ListVars
        Pause
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
        loop_list(title,path,callback)
    }
    catch Error as err {
        ListVars
        Pause
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
