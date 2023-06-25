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

# echo $config.full #把特殊符号放到json里面就行了, 直接写进脚本不行
# echo "–"
