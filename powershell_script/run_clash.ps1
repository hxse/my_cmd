Set-PSDebug -Trace 1
cd "D:\App\proxy\clash-premium"
. "D:\App\proxy\clash-premium\clash-windows-386.exe" -d "D:\my_repo\clash-rule-providers" -ext-ui "D:\App\proxy\yacd-gh-pages\yacd-gh-pages"
Set-PSDebug -Trace 0
