$dir = Get-Location
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$scriptDir\tool.ps1" #用.可以扩大作用域,用&的话函数就没有副作用了 https://stackoverflow.com/questions/54661916/what-is-the-difference-between-dot-and-ampersand-in-powershell

Function e {
    # $clashPathDir = "D:\App\proxy\clash-premium"
    # $clashPath = "D:\App\proxy\clash-premium\clash-windows-386.exe"
    $clashPathDir = "D:\App\proxy\clash-meta"
    $clashPath = "D:\App\proxy\clash-meta\clash.meta-windows-amd64-compatible.exe"
    $clashDir="D:\my_repo\clash-rule-providers"
    $uiPath="D:\App\proxy\yacd-gh-pages\yacd-gh-pages"
    $sudo="C:\Users\hxse\scoop\shims\sudo.exe"
    $command="& `"$sudo`" `"$clashPath`" -d `"$clashDir`" -ext-ui `"$uiPath`""

    cd $clashPathDir
    Write-ColorOutput yellow ("---describeStart---, press ctrl-c break press e re-run")
    Write-ColorOutput green ($command)
    Write-ColorOutput yellow ("---describeEnd---")
    iex $command

}
# Set-PSDebug -Trace 1
e
# Set-PSDebug -Trace 0
