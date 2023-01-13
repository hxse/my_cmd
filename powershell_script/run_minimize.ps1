# windows-terminal的路径,不能用scoop current里的快捷路径,因为没法识别真实路径
function e {
    autohotkey /restart "D:\my_repo\my_cmd\ahk_script\run_minimize.ahk" "hidden" "C:\Users\hxse\scoop\apps\windows-terminal\1.15.3465.0\WindowsTerminal.exe" "run_clash" "active_windows_keyboard" "alist" "webdav" "ftp" "subcovert" "SubConverter v0.7.1" "cat"
}
Set-PSDebug -Trace 1
e
Set-PSDebug -Trace 0
