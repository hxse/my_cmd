wt -w 0 new-tab --title "cat" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\;& 'D:\my_repo\my_cmd\powershell_script\run_cat.ps1' 'D:\my_repo\my_cmd\mprocs\mprocs.yaml'"

# 直接用autohotkey无法接受exitcode, 所以用绝对路径
# https://github.com/chocolatey/home/issues/124
$code = (Start-Process -FilePath "$env:USERPROFILE\scoop\apps\autohotkey\current\UX\AutoHotkeyUX.exe" -Args "D:\my_repo\my_cmd\ahk_script\check_exist.ahk `"^cat$`" `"^.*\\WindowsTerminal.exe$`" 60"  -PassThru -Wait  -WindowStyle Minimized).exitCode
if ($code -eq 0) {
    return
}

powershell -Command "Start-Sleep -Seconds 0.5"
wt -w 0 new-tab --title "mprocs" -p "powershell" powershell -NOLogo -NoExit -Command ". D:\my_repo\my_cmd\powershell_script\my_init.ps1\; mprocs -c 'D:\my_repo\my_cmd\mprocs\mprocs.yaml'"

# https://github.com/PowerShell/PowerShell/issues/3028
# D:\my_repo\my_cmd\powershell_script\run-hidden.exe PowerShell  -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process D:\my_repo\my_cmd\powershell_script\run-hidden.exe -ArgumentList 'PowerShell -WindowStyle Hidden -NoProfile   -ExecutionPolicy Bypass -File """D:\my_repo\my_cmd\powershell_script\run_minimize.ps1"""'}"
D:\my_repo\my_cmd\powershell_script\run-ps.vbs D:\my_repo\my_cmd\powershell_script\run_minimize.ps1
exit
