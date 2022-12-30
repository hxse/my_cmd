wt -w 0 new-tab --title "subcovert" -p "Windows PowerShell" PowerShell.exe -NoExit -Command "D:\my_repo\my_cmd\script\subcovert.ps1"
powershell -Command "Start-Sleep -Seconds 1"
wt -w 0 new-tab --title "clash_control" -p "Windows PowerShell" PowerShell.exe -NoExit -Command "D:\my_repo\my_cmd\script\clash_control.ps1"
wt -w 0 new-tab --title "clash_yacd" -p "Windows PowerShell" PowerShell.exe -NoExit -Command "D:\my_repo\my_cmd\script\clash_yacd.ps1"
wt -w 0 new-tab --title "run_clash" -p "Windows PowerShell" PowerShell.exe -NoExit -Command "D:\my_repo\my_cmd\script\run_clash.ps1"


