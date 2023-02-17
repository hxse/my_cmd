wt -w 0 new-tab --title "run_mprocs" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;. D:\my_repo\my_cmd\powershell_script\run_mprocs.ps1"

powershell -Command "Start-Sleep -Seconds 1"
@REM https://github.com/PowerShell/PowerShell/issues/3028
@REM D:\my_repo\my_cmd\powershell_script\run-hidden.exe PowerShell  -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process D:\my_repo\my_cmd\powershell_script\run-hidden.exe -ArgumentList 'PowerShell -WindowStyle Hidden -NoProfile   -ExecutionPolicy Bypass -File """D:\my_repo\my_cmd\powershell_script\run_minimize.ps1"""'}"
D:\my_repo\my_cmd\powershell_script\run-ps.vbs D:\my_repo\my_cmd\powershell_script\run_minimize.ps1
exit
