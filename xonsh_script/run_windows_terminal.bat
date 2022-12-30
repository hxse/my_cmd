::在xonsh里面用需要在""前面添加r,避免路径被转义
:: wt -w 0 new-tab --title "subcovert" -p "xonsh" cmd /K "D:\my_repo\my_cmd\xonsh_script\run_xonsh_command.bat" "echo haha"
:: wt -w 0 new-tab --title "subcovert" -p "xonsh" cmd /K "D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat" "D:\my_repo\my_cmd\xonsh_script\test 2.xsh"

::用cmd
wt -w 0 new-tab --title "subcovert" -p "cmd" cmd /K "D:\my_repo\my_cmd\xonsh_script\run_xonsh_command.bat" "cat r'D:\my_repo\my_cmd\xonsh_script\run_windows_terminal.bat'"
timeout 1
wt -w 0 new-tab --title "subcovert" -p "cmd" cmd /K "D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat" "D:\my_repo\my_cmd\xonsh_script\scirpt\subcovert.xsh"
wt -w 0 new-tab --title "subcovert" -p "cmd" cmd /K "D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat" "D:\my_repo\my_cmd\xonsh_script\scirpt\clash_yacd.xsh"
wt -w 0 new-tab --title "subcovert" -p "cmd" cmd /K "D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat" "D:\my_repo\my_cmd\xonsh_script\scirpt\clash_control.xsh"
wt -w 0 new-tab --title "subcovert" -p "cmd" cmd /K "D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat" "D:\my_repo\my_cmd\xonsh_script\scirpt\ftp.xsh"
wt -w 0 new-tab --title "subcovert" -p "cmd" cmd /K "D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat" "D:\my_repo\my_cmd\xonsh_script\scirpt\run_clash.xsh"

::用gitbash
::wt -w 0 new-tab --title "subcovert" -p "git base" bash "D:\my_repo\my_cmd\xonsh_script\run_xonsh_command.sh" "cat r'D:\my_repo\my_cmd\xonsh_script\run_windows_terminal.bat'"
::timeout 1
::wt -w 0 new-tab --title "subcovert" -p "git base" bash "D:\my_repo\my_cmd\xonsh_script\run_xonsh.sh" "D:\my_repo\my_cmd\xonsh_script\scirpt\subcovert.xsh"
::wt -w 0 new-tab --title "subcovert" -p "git base" bash "D:\my_repo\my_cmd\xonsh_script\run_xonsh.sh" "D:\my_repo\my_cmd\xonsh_script\scirpt\clash_yacd.xsh"
::wt -w 0 new-tab --title "subcovert" -p "git base" bash "D:\my_repo\my_cmd\xonsh_script\run_xonsh.sh" "D:\my_repo\my_cmd\xonsh_script\scirpt\clash_control.xsh"
::wt -w 0 new-tab --title "subcovert" -p "git base" bash "D:\my_repo\my_cmd\xonsh_script\run_xonsh.sh" "D:\my_repo\my_cmd\xonsh_script\scirpt\ftp.xsh"
::wt -w 0 new-tab --title "subcovert" -p "git base" bash "D:\my_repo\my_cmd\xonsh_script\run_xonsh.sh" "D:\my_repo\my_cmd\xonsh_script\scirpt\run_clash.xsh"

::用powershell,感觉不行
::wt -w 0 new-tab --title "subcovert" -p "powershell" powershell -C ". D:\my_repo\my_cmd\xonsh_script\run_xonsh_command.ps1" "cat 'D:\my_repo\my_cmd\xonsh_script\test 2.xsh' "
