# windows-terminal的路径,不能用scoop current里的快捷路径,因为没法识别真实路径
chcp 65001

function e {
    # 变量后缀是regex的参数需要\\转义, 因为格式是正则表达式
    $mode = "hidden"
    $iconPath = "C:\Users\hxse\scoop\apps\windows-terminal\1.15.3465.0\WindowsTerminal.exe"
    $pathRegex = "^C:\\Users\\hxse\\scoop\\apps\\windows-terminal\\.*\\WindowsTerminal.exe$"
    $titleRegex = "^run_mprocs^", "^run_clash$", "^.*run_clash$", "^run_clash_providers$", "^active_windows_keyboard$", "^alist$", "^player$", "^webdav$", "^ftp$", "^subcovert$", "^SubConverter.*$", "^cat$", "^sync_note$"

    autohotkey /restart "D:\my_repo\my_cmd\ahk_script\run_minimize.ahk" $mode $iconPath $pathRegex $titleRegex
}
Set-PSDebug -Trace 1
e
Set-PSDebug -Trace 0
