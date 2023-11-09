$dir = Get-Location
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$scriptDir\tool.ps1" #用.可以扩大作用域, 用&的话函数就没有副作用了 https://stackoverflow.com/questions/54661916/what-is-the-difference-between-dot-and-ampersand-in-powershell

Function e {
    $dirPath = "D:\Note\logseq_note"
    $command = ". `".\auto sync logseq_note.bat`" 180"

    cd $dirPath
    Write-ColorOutput yellow ("---describeStart---, press ctrl-c break press e re-run")
    Write-ColorOutput green ($command)
    Write-ColorOutput yellow ("---describeEnd---")
    iex $command

}
# Set-PSDebug -Trace 1
e
# Set-PSDebug -Trace 0
