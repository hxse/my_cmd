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
# echo $config.full #把特殊符号放到json里面就行了, 直接写进脚本不行
# echo "–"

function getParam($argsAll) {
    # foreach ($a in $argsAll) {
    #     Write-Host $a
    # }
    $p = [System.Collections.ArrayList]@()
    $r = [System.Collections.ArrayList]@()
    $n = 0
    $isAddKey = $false
    foreach ($a in $argsAll) {
        # echo $n
        if ($a -match "-.*") {
            $null = $p.Add((@{
                        "key"   = $a
                        "value" = "`"`""
                    }))
            $isAddKey = $true
        }
        else {
            if ($isAddKey) {
                $p[-1].value = $a
                $isAddKey = $false
            }
            else {
                $null = $r.Add($a)
            }
        }
        $n++
    }
    return @($r, $p)
}

function getParamStr($argsAll) {
    $aArr, $kArr = getParam $argsAll
    $aArr = $aArr -join " "
    $newKArr = ""
    foreach ($k in $kArr) {
        $newKArr = "$newKArr $($k.key) $($k.value)"
    }
    return @($aArr, $newKArr.Trim())
}
function checkEq($str, $str2) {
    # 合并参数的逻辑, -list 和 --list 视为一样
    return ($str -eq $str2) -or (($str -eq "-$str2")) -or (("-$str" -eq $str2))
}
function mergeParamo($argsAll, $def_argsAll) {
    # 第一个参数是用户参数, 第二个参数是默认参数, 用户参数会覆盖默认参数
    # 第二个参数需要数组, 不能是字符串
    $aArr, $kArr = getParam $argsAll
    $def_argsAll = $def_argsAll.Trim()

    #用正则循环, 把""的内容替换成特殊id
    $n = 0
    $reg = "^(.*)(`".*`")(.*)$"
    # $reg = "^(.*)([^\\]`".*[^\\]`")(.*)$"#增加一个\"转义, powershell字符串用\`",不过容易出bug, 会导致截断空格
    $data = @{}
    while (($def_argsAll -match $reg) -eq $true) {
        $k = "##id__$($n)__id##" #格式越随机越安全
        $data[$k] = $matches.2
        $def_argsAll = $def_argsAll -replace $reg, "$($matches.1) $($k) $($matches.3)"
        $n++
    }
    $da = $def_argsAll.split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)

    #如何处理转义 \\" 替换掉
    # $new_data = @{}
    # $originStr = '\\"'
    # $targetStr = ''
    # foreach ($key in $data.Keys) {
    #     $new_data[$key] = $data[$key]
    #     if ($originStr -ne $targetStr ) {
    #         while (($new_data[$key] -match $originStr) -eq $true) {
    #             $new_data[$key] = $new_data[$key] -replace $originStr, $targetStr
    #         }
    #     }
    # }
    # $data = $new_data


    $def_aArr, $def_kArr = getParam ($da)


    #根据特殊id把替换回原内容, 处理args
    $new_def_aArr = [System.Collections.ArrayList]@()
    $new_def_kArr = [System.Collections.ArrayList]@()

    $n = 0
    foreach ($a in $def_aArr) {
        if ($data.ContainsKey($a)) {
            $null = $new_def_aArr.Add($data[$a])
        }
        else {
            $null = $new_def_aArr.Add( $def_aArr[$n])
        }
        $n++
    }

    #根据特殊id把替换回原内容, 处理kargs
    $n = 0
    foreach ($k in $def_kArr) {
        $t = $k.value
        if ($data.ContainsKey($t)) {
            $n_k = @{}
            $n_k.key = $def_kArr[$n].key
            $n_k.value = $data[$t]
            $null = $new_def_kArr.Add($n_k)
        }
        else {
            $null = $new_def_kArr.Add( $def_kArr[$n]) #不用$null, 会产生莫名其妙的值输出到return
        }
        $n++
    }
    $def_aArr = $new_def_aArr
    $def_kArr = $new_def_kArr

    # 把用户参数和默认参数合并,处理args
    $n = 0
    foreach ($a in $aArr) {
        if ($n -le ($def_aArr.length.length - 1 )) {
            $def_aArr[$n] = $a
        }
        else {
            $null = $def_aArr.Add($a)
        }
        $n++
    }

    # 把用户参数和默认参数合并,处理kargs
    $_kArr = [System.Collections.ArrayList]@()
    foreach ($k in $kArr) {
        $flag = $false
        foreach ($d_k in $def_kArr) {
            if ((checkEq $k.key $d_k.key ) -eq $true) {
                $d_k.value = $k.value
                $flag = $true
            }
        }
        if ($flag -eq $false) {
            $f = $false
            foreach ($_k in $_kArr) {
                if ((checkEq $_k.key $k.key) -eq $true ) {
                    $_k.value = $k.value
                    $f = $true
                }
                else {
                    $f = $false
                }
            }
            if ($f -eq $false) {
                $null = $_kArr.Add($k)
            }
        }
    }
    foreach ($k in $_kArr) {
        $null = $def_kArr.Add($k)
    }

    return @($def_aArr, $def_kArr)
}

function mergeParamoStr($argsAll, $def_argsAll) {

    $aArr, $kArr = mergeParamo  $argsAll $def_argsAll

    $newAArr = ""
    foreach ($a in $aArr) {
        if (!"$a".StartsWith('"') -and !"$a".EndsWith('"') ) {
            $a = "`"$a`""
        }
        $newAArr = "$newAArr $a"
    }

    $newKArr = ""
    foreach ($k in $kArr) {
        if (!"$($k.value)".StartsWith('"') -and !"$($k.value)".EndsWith('"') ) {
            $k.value = "`"$($k.value)`""
        }
        $newKArr = "$newKArr $($k.key) $($k.value)"
    }
    return @($newAArr.trim(), $newKArr.Trim())
}
