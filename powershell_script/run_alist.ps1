$dir = Get-Location
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$scriptDir\tool.ps1" #用.可以扩大作用域, 用&的话函数就没有副作用了 https://stackoverflow.com/questions/54661916/what-is-the-difference-between-dot-and-ampersand-in-powershell

Function e {
    # 备份的方法是,复制 C:\Users\hxse\scoop\apps\alist\3.7.2\data\ 文件夹下的 config.json 和 datga.db
    $command = "alist server"

    Write-ColorOutput yellow ("---describeStart---, press ctrl-c break press e re-run")
    Write-ColorOutput green ($command)
    Write-ColorOutput yellow ("---describeEnd---")
    iex $command

}
# Set-PSDebug -Trace 1
e
# Set-PSDebug -Trace 0
