$dir = Get-Location
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
. "$scriptDir\tool.ps1"

Function e {
    $dirPath= "D:\App\proxy\subconverter\subconverter"
    $exePath="D:\App\proxy\subconverter\subconverter\subconverter.exe"
    $command="& `"$exePath`""

    cd $dirPath
    Write-ColorOutput yellow ("---describeStart---, press ctrl-c break press e re-run")
    Write-ColorOutput green ($command)
    Write-ColorOutput yellow ("---describeEnd---")
    iex $command

}
# Set-PSDebug -Trace 1
e
# Set-PSDebug -Trace 0
