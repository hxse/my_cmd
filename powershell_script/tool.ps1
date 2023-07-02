$dir = Get-Location
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

function ReadFile($path) {
    return (Get-Content -Raw -Encoding utf8  -Path "$path" )
}


# 读取json文件并转换为对象
function ReadJsonFile($path) {
    $content = ReadFile $path
    return ConvertFrom-Json -InputObject $content
}

# 读取,调用上面的函数
$config = (ReadJsonFile "$scriptDir\config\config.json" )


function Write-ColorOutput($ForegroundColor) {
    # save the current color
    $fc = $host.UI.RawUI.ForegroundColor

    # set the new color
    $host.UI.RawUI.ForegroundColor = $ForegroundColor

    # output
    if ($args) {
        Write-Output $args
    }
    else {
        $input | Write-Output
    }

    # restore the original color
    $host.UI.RawUI.ForegroundColor = $fc
}
function skipArgs($arr, $skipNumber, $skipNumberLast) {
    if ($arr -eq $null -or $skipNumber -eq $null  ) {
        echo "It's empty"
        return
    }
    if ($skipNumberLast -eq $null) {
        $skipNumberLast = 0
    }
    return  ($arr | Select-Object -Skip $skipNumber | Select-Object -SkipLast $skipNumberLast) -join ' '
}
function skipArgsQuote($arr, $skipNumber, $skipNumberLast) {
    $res = skipArgs $arr $skipNumber $skipNumberLast
    return (($res -split " ") -replace '(^.*$)', '"$1"') -join ' '
}


function run_t {
    $arr = [System.Collections.ArrayList]@()
    $arr.Add('aa')
    $arr.Add('bb')
    return $arr
}

function test {

}
