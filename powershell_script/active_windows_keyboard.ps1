function e {
    cd "D:\my_repo\py-active-windows-keyboard";
    pdm run python ".\active_window.py" --path "config.json"
}
Set-PSDebug -Trace 1
e
Set-PSDebug -Trace 0
