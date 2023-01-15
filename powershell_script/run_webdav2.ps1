function e {
    wsgidav --host=0.0.0.0 --port=8002 --root="F:\" --auth=anonymous
}
Set-PSDebug -Trace 1
e
Set-PSDebug -Trace 0
