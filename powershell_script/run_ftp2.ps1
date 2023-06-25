$dir = Get-Location
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$scriptDir\tool.ps1" #用.可以扩大作用域, 用&的话函数就没有副作用了 https://stackoverflow.com/questions/54661916/what-is-the-difference-between-dot-and-ampersand-in-powershell

Function e {
    $dirPath = "F:\"
    $pythonPath = "C:/Users/hxse/scoop/apps/python310/current/python.exe"
    $ftpName = $env:ftpName
    $ftpPassword = $env:ftpPassword
    $port = 23
    $command = "& `"$pythonPath`" -m pyftpdlib -p $port --username=$ftpName --password=$ftpPassword"

    cd $dirPath
    Write-ColorOutput yellow ("---describeStart---, press ctrl-c break press e re-run")
    Write-ColorOutput green ($command)
    Write-ColorOutput yellow ("---describeEnd---")
    iex $command

}
# Set-PSDebug -Trace 1
e
# Set-PSDebug -Trace 0
