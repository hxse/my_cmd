function e {
    cd "D:\App\proxy\clash-dashboard\dist"
    . "C:\Users\hxse\AppData\Local\Programs\Python\Python310\python.exe" -m "http.server" 9091
}
Set-PSDebug -Trace 1
e
Set-PSDebug -Trace 0
