Set-PSDebug -Trace 1
cd "D:\App\proxy\yacd-gh-pages\yacd-gh-pages"
. "C:\Users\hxse\AppData\Local\Programs\Python\Python310\python.exe" -m "http.server" 9092
Set-PSDebug -Trace 0
