#在xonsh里面用需要在""前面添加r,避免路径被转义
# wt -w 0 new-tab --title "subcovert" -p "xonsh" cmd /K "D:\my_repo\my_cmd\xonsh_script\run_xonsh_command.bat" "echo haha"
# wt -w 0 new-tab --title "subcovert" -p "xonsh" cmd /K "D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat" "D:\my_repo\my_cmd\xonsh_script\test 2.xsh"

wt -w 0 new-tab --title "subcovert" -p "xonsh" cmd /K r"D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat" r"D:\my_repo\my_cmd\xonsh_script\scirpt\subcovert.xsh"
timeout 2
wt -w 0 new-tab --title "subcovert" -p "xonsh" powershell -c r"D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat" r"D:\my_repo\my_cmd\xonsh_script\scirpt\clash_yacd.xsh"
wt -w 0 new-tab --title "subcovert" -p "xonsh" cmd /K r"D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat" r"D:\my_repo\my_cmd\xonsh_script\scirpt\clash_control.xsh"
wt -w 0 new-tab --title "subcovert" -p "xonsh" cmd /K r"D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat" r"D:\my_repo\my_cmd\xonsh_script\scirpt\run_clash.xsh"

#wt -w 0 new-tab --title "subcovert" -p "xonsh" xonsh -c r"cmd /K r'D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat' r'D:\my_repo\my_cmd\xonsh_script\scirpt\subcovert.xsh'"
#wt -w 0 new-tab --title "subcovert" -p "xonsh" xonsh -c r"cmd /K r'D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat' r'D:\my_repo\my_cmd\xonsh_script\scirpt\clash_yacd.xsh'"
#wt -w 0 new-tab --title "subcovert" -p "xonsh" xonsh -c r"cmd /K r'D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat' r'D:\my_repo\my_cmd\xonsh_script\scirpt\clash_control.xsh'"
#wt -w 0 new-tab --title "subcovert" -p "xonsh" xonsh -c r"cmd /K r'D:\my_repo\my_cmd\xonsh_script\run_xonsh.bat' r'D:\my_repo\my_cmd\xonsh_script\scirpt\run_clash.xsh'"