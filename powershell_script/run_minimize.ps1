Set-PSDebug -Trace 1
# windows-terminal的路径,不能用scoop current里的快捷路径,因为没法识别真实路径
autohotkey /restart "D:\my_repo\my_cmd\ahk_script\run_minimize.ahk" "run_clash" "C:\Users\hxse\scoop\apps\windows-terminal\1.15.3465.0\WindowsTerminal.exe" "hidden"
Set-PSDebug -Trace 0
