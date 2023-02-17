function e {
    cd D:\my_repo\my_cmd\mprocs
    mprocs -c .\mprocs.yaml
}
Set-PSDebug -Trace 1
e
Set-PSDebug -Trace 0
