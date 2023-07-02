function getParam_from_array($argsAll) {
    $p = [System.Collections.ArrayList]@()
    $r = [System.Collections.ArrayList]@()
    $n = 0
    $isAddKey = $false
    foreach ($a in $argsAll) {
        # echo $n
        if ($a -match "-.*") {
            $p.Add((@{
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
                $r.Add($a)
            }
        }
        $n++
    }
    return @($r, $p)
}
function replace2($text, $reg, $target) {
    while (($text -match $reg) -eq $true) {
        #替换转义字符, 把$origin替换成target
        # Write-Host $text 2333333
        $text = $text -replace $reg, "$($matches.1)$($target)$($matches.3)"
    }
    return @(@(), $text)
}
function replaceEscapeChar($argsAll) {
    # 参数是字符串, 函数返回[string,object<key,value>]
    # 用正则循环, 把字符串中被转义字符```"包裹内容替换成特殊id
    $origin = '```"'
    $target = '`"'
    $reg = "^(.*)($origin.*$origin)(.*)$"
    $reg2 = "^(.*)($origin)(.*)$"
    $dataDict = @{}
    $n = 0
    while (($argsAll -match $reg) -eq $true) {
        $k = "__#esc#_$($n)_#esc#__" #格式越随机越安全
        # $dataDict[$k] = $matches.2
        $null, $text = replace2 $matches.2 $reg2 $target |   select -Last 2
        $dataDict[$k] = $text
        $argsAll = $argsAll -replace $reg, "$($matches.1)$($k)$($matches.3)"
        $n++
    }
    return @($argsAll, $dataDict)
}
function replaceQuota2Id ($argsAll) {
    # 参数是字符串, 函数返回[string,object<key,value>]
    # 用正则循环, 把字符串中被""包裹内容替换成特殊id
    $n = 0
    $reg = '^(.*)(".*")(.*)$'
    $dataDict = @{}
    while (($argsAll -match $reg) -eq $true) {
        $k = "__#id#_$($n)_#id#__" #格式越随机越安全
        $dataDict[$k] = $matches.2
        $argsAll = $argsAll -replace $reg, "$($matches.1)$($k)$($matches.3)"
        $n++
    }
    return @($argsAll, $dataDict)
}

function matchDictKey($dataDict, $a) {
    foreach ($k in $dataDict.Keys  ) {
        $reg = "^(.*)($k)(.*)$"
        if (($a -match $reg ) -eq $true) {
            return @(@(), $a -replace $reg, "$($Matches.1)$($dataDict[$k])$($Matches.3)")
        }
    }
    return @(@(), $null)
}
function restore ($arr, $dataDict) {
    $new_arr = [System.Collections.ArrayList]@()
    foreach ($a in $arr) {
        $null, $v = (matchDictKey $dataDict $a )  |   select -Last 2
        if ($v -eq $null) {
            $new_arr.Add($a)
        }
        else {
            $new_arr.Add($v)
        }
    }
    # return $new_arr
    return  @( @(), $new_arr)
}

function getParam_from_str($argsAll) {
    # 替换转义符号,双引号目前只支持两层转义, 转义符号"`"", "``````"", 或者'"','```"'
    $text, $dataDict = replaceEscapeChar $argsAll  |   select -Last 2
    # 替换双引号
    $text2, $dataDict2 = replaceQuota2Id $text  |   select -Last 2
    $arr = $text2.split(" ")
    $null , $arr2 = restore $arr $dataDict2  |   select -Last 2
    $null, $arr3 = restore $arr2 $dataDict |   select -Last 2
    $arr4 = [System.Collections.ArrayList]@()
    foreach ( $a in $arr3) {
        if (($a.trim()).length -gt 0) {
            $arr4.Add($a.trim())
        }
    }

    # 转换字符串数组, 成参数数组
    $argsArr, $kargsArr = getParam_from_array $arr4 | select -Last 2
    # foreach ($i in $argsArr) {
    #     Write-Host args: $i
    # }
    # foreach ($i in $kargsArr) {
    #     Write-Host kargs: $i.key $i.value
    # }
    return @($argsArr, $kargsArr)
}
function getParam($argsAll) {
    # foreach ($a in $argsAll) {
    #     Write-Host $a
    # }
    # 当输入类型是数组时
    if ($argsAll.gettype().Name -eq 'ArrayList' -or $argsAll.gettype().Name -eq 'Object[]') {
        $argsArr, $kargsArr = getParam_from_array $argsAll  |   select -Last 2
        return  @($argsArr, $kargsArr)
    }
    # 当输入类型是字符串时, 处理比较复杂, 需要转义双引号
    # 双引号目前只支持两层转义, 转义符号`",```"
    if ($argsAll.gettype().Name -eq 'String') {
        $argsArr, $kargsArr = getParam_from_str $argsAll  |  select -Last 2
        return @($argsArr, $kargsArr)
    }
}

function warpStr($aArr, $kArr, $enableQuota = $true) {
    $newAArr = ""
    foreach ($a in $aArr) {
        if (!"$a".StartsWith('"') -and !"$a".EndsWith('"') ) {
            if ($enableQuota) {
                $a = "`"$a`""
            }
        }
        $newAArr = "$newAArr $a"
    }

    $newKArr = ""
    foreach ($k in $kArr) {
        if (!"$($k.value)".StartsWith('"') -and !"$($k.value)".EndsWith('"') ) {
            if ($enableQuota) {
                $k.value = "`"$($k.value)`""
            }
        }
        $newKArr = "$newKArr $($k.key) $($k.value)"
    }
    return @($newAArr.trim(), $newKArr.Trim())
}
function getParamStr($argsAll) {
    $aArr, $kArr = getParam $argsAll  |  select -Last 2
    $new_aArr, $new_kArr = warpStr $aArr $kArr $true  |  select -Last 2
    return @($new_aArr, $new_kArr)
}

function checkEq($str, $str2) {
    # 合并参数的逻辑, -list 和 --list 视为一样
    return ($str -eq $str2) -or (($str -eq "-$str2")) -or (("-$str" -eq $str2))
}

function mergerArgs($aArr, $kArr, $def_aArr, $def_kArr) {
    # 只支持转义后的传数组格式, 如果用字符串随便按空格切分成数组, 就容易有转义问题
    if (!($aArr.gettype().Name -eq 'ArrayList' -or $aArr.gettype().Name -eq 'Object[]')) {
        Write-Host "error: 合并参数时需要传入数组类型, 当前传入类型是 "$aArr.gettype().Name
        return
    }

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

    # 先把默认参数去重
    $newArr = [System.Collections.ArrayList]@()
    $n = 0
    foreach ($d_k in $def_kArr) {
        $n2 = 0
        $flag = $true
        foreach ($d_k2 in $def_kArr) {
            if ((checkEq $d_k.key $d_k2.key ) -eq $true) {
                if ($n -lt $n2) {
                    # $newArr.Add(@($n, $n2))
                    $flag = $false
                }
            }
            $n2++
        }
        if ($flag ) {
            $newArr.Add($d_k)
        }
        $n++
    }
    $def_kArr = $newArr

    # 再把用户参数和默认参数合并,处理kargs
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
function mergerArgsStr($aArr, $kArr, $def_aArr, $def_kArr) {
    $new_aArr, $new_kArr = mergerArgs $aArr $kArr $def_aArr $def_kArr |  select -Last 2
    $new_aArr2, $new_kArr2 = warpStr  $new_aArr $new_kArr |  select -Last 2
    return @($new_aArr2, $new_kArr2)
}

function p_test {
    # 字符串的效果要跟参数数组对齐, 参数测试命令: p_test a b -p p --prompt "hello world, ```"how are you```", thank you" -kk -k "wdt"
    # 双引号目前只支持两层转义, 转义符号"`"","``````"", 或者'"','```"'
    $prompt = "--initial-prompt `"Please, listen to dialogue and question. the example question one: What is the color of this apple? Is it, a red, b green, c yellow? the example question two: What kind of transportation did he take?  Was it, a car, b bike, c bus? A final note, pay attention to the use of punctuation.`""
    $def_args = "`"hello   world`" a   b -p p -g `"as df`" --prompt `"hello world, ```````"how are you```````", thank you`"  --g gf haha -kk `"sdf klj`"  -k `"adsf ghjk l`" -g `"haha heihei`""


    # 解析默认参数, 返回数组格式
    # $aArr, $kArr = getParam  $def_args  | select -Last 2 #$args
    # foreach ($a in $aArr) {
    #     Write-Host args: $a
    # }
    # foreach ($k in $kArr) {
    #     Write-Host kargs: $k.key $k.value
    # }


    # 解析用户参数, 返回数组格式
    # $aArr, $kArr = getParam  $args  | select -Last 2 #$args
    # foreach ($a in $aArr) {
    #     Write-Host args: $a
    # }
    # foreach ($k in $kArr) {
    #     Write-Host kargs: $k.key $k.value
    # }


    # 解析默认参数和用户参数, 返回str格式
    # $aArr, $kArr = getParamStr  $args  | select -Last 2 #$args
    # Write-Host "$aArr $kArr" 55555

    # $def_aArr, $def_kArr = getParamStr  $def_args  | select -Last 2 #$args
    # Write-Host "$def_aArr $def_kArr" 66666


    # 合并默认参数和用户参数, 返回str格式
    $aArr, $kArr = getParam  $args  | select -Last 2 #$args
    $def_aArr, $def_kArr = getParam  $def_args  | select -Last 2 #$args

    $new_aArr, $new_kArr = mergerArgsStr $aArr $kArr $def_aArr $def_kArr  | select -Last 2 #$args
    Write-Host "$new_aArr $new_kArr" 66666
}
