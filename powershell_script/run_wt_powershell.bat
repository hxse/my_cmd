wt -w 0 new-tab --title "cat" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;& 'D:\my_repo\my_cmd\powershell_script\run_cat.ps1' 'D:\my_repo\my_cmd\powershell_script\run_wt_powershell.bat'"

powershell -Command "Start-Sleep -Seconds 1"
wt -w 0 new-tab --title "subcovert" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;. D:\my_repo\my_cmd\powershell_script\run_subcovert.ps1"

powershell -Command "Start-Sleep -Seconds 0.5"
wt -w 0 new-tab --title "ftp" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;. D:\my_repo\my_cmd\powershell_script\run_ftp.ps1"

powershell -Command "Start-Sleep -Seconds 0.5"
wt -w 0 new-tab --title "ftp" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;. D:\my_repo\my_cmd\powershell_script\run_ftp2.ps1"

powershell -Command "Start-Sleep -Seconds 0.5"
wt -w 0 new-tab --title "webdav" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;. D:\my_repo\my_cmd\powershell_script\run_webdav_config.ps1"

powershell -Command "Start-Sleep -Seconds 0.5"
wt -w 0 new-tab --title "webdav" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;. D:\my_repo\my_cmd\powershell_script\run_webdav.ps1"

powershell -Command "Start-Sleep -Seconds 0.5"
wt -w 0 new-tab --title "webdav" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;. D:\my_repo\my_cmd\powershell_script\run_webdav2.ps1"

powershell -Command "Start-Sleep -Seconds 0.5"
wt -w 0 new-tab --title "player" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;. D:\my_repo\my_cmd\powershell_script\run_player.ps1"

powershell -Command "Start-Sleep -Seconds 0.5"
wt -w 0 new-tab --title "alist" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;. D:\my_repo\my_cmd\powershell_script\run_alist.ps1"

powershell -Command "Start-Sleep -Seconds 0.5"
wt -w 0 new-tab --title "active_windows_keyboard" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;. D:\my_repo\my_cmd\powershell_script\active_windows_keyboard.ps1"


powershell -Command "Start-Sleep -Seconds 0.5"
wt -w 0 new-tab --title "run_clash_providers" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;. D:\my_repo\my_cmd\powershell_script\run_clash_providers.ps1"


powershell -Command "Start-Sleep -Seconds 0.5"
wt -w 0 new-tab --title "run_clash" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;. D:\my_repo\my_cmd\powershell_script\run_clash.ps1"

powershell -Command "Start-Sleep -Seconds 0.5"
@REM https://github.com/PowerShell/PowerShell/issues/3028
@REM D:\my_repo\my_cmd\powershell_script\run-hidden.exe PowerShell  -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process D:\my_repo\my_cmd\powershell_script\run-hidden.exe -ArgumentList 'PowerShell -WindowStyle Hidden -NoProfile   -ExecutionPolicy Bypass -File """D:\my_repo\my_cmd\powershell_script\run_minimize.ps1"""'}"
D:\my_repo\my_cmd\powershell_script\run-ps.vbs D:\my_repo\my_cmd\powershell_script\run_minimize.ps1
exit
