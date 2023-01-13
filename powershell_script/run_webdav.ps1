function e {
    wsgidav --host=0.0.0.0 --port=8001 --root="E:\" --auth=anonymous
}
Set-PSDebug -Trace 1
e
Set-PSDebug -Trace 0
