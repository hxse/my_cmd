::配合软件可以把wt隐藏到托盘里
::https://github.com/benbuck/rbtray
::[4t Tray Minimizer Free/Pro - Minimize Outlook](https://www.4t-niagara.com/tray.html)
::[最小化到托盘 · Issue #47 · microsoft/PowerToys](https://github.com/microsoft/PowerToys/issues/47)
wt -w 0 new-tab --title "cat" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;& 'D:\my_repo\my_cmd\powershell_script\run_cat.ps1' 'D:\my_repo\my_cmd\powershell_script\run_wt_powershell.bat'"
powershell -Command "Start-Sleep -Seconds 1"
wt -w 0 new-tab --title "subcovert" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;D:\my_repo\my_cmd\powershell_script\subcovert.ps1"
powershell -Command "Start-Sleep -Seconds 0.6"
::wt -w 0 new-tab --title "ftp" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;D:\my_repo\my_cmd\powershell_script\run_ftp.ps1"
::powershell -Command "Start-Sleep -Seconds 0.6"
wt -w 0 new-tab --title "webdav" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;D:\my_repo\my_cmd\powershell_script\run_webdav.ps1"
powershell -Command "Start-Sleep -Seconds 0.6"
wt -w 0 new-tab --title "alist" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;D:\my_repo\my_cmd\powershell_script\run_alist.ps1"
powershell -Command "Start-Sleep -Seconds 0.6"
wt -w 0 new-tab --title "powershell" -p "powershell" powershell -NOLogo -NoExit -File "D:\my_repo\my_cmd\powershell_script\my_init.ps1"
powershell -Command "Start-Sleep -Seconds 0.6"
wt -w 0 new-tab --title "run_clash" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;D:\my_repo\my_cmd\powershell_script\run_clash.ps1"
powershell -Command "Start-Sleep -Seconds 0.6"
