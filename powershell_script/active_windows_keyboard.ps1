Set-PSDebug -Trace 1
cd "D:\my_repo\py-active-windows-keyboard"
pdm run python .\active_window.py --path config.json
Set-PSDebug -Trace 0
