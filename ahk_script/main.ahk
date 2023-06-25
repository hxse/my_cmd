cacheDir := "cache"
newName := "haha.ahk" ;用参数输入
scriptName := "test.ahk"
cacheFullDir := A_ScriptDir "\" cacheDir
scriptFullName := A_ScriptDir "\" scriptName

maxNumber := 0
Loop Files, cacheFullDir "\*" ;
{
    word_array := StrSplit(A_LoopFileName, "_")
    if (word_array.length == 2) {
        ;MsgBox "检测到文件"
        if (Number(word_array[1]) >= maxNumber) {
            maxNumber := Number(word_array[1]) + 1
            ;MsgBox maxNumber
        }
    }
}
cacheFullScript := cacheFullDir "\" maxNumber "_" newName
FileCopy scriptFullName, cacheFullScript, 1 ;1为复制时覆盖文件

test := "D:\my_repo\my_cmd\ahk_scipt\cache\0_haha.ahk"

compare(path, ahk_list)
{
    for this_id in ahk_list {
        this_class := WinGetClass(this_id)
        this_title := WinGetTitle(this_id)
        word_array := StrSplit(path, "\")
        word_array2 := StrSplit(this_title, "\")
        if (word_array.length == word_array2.length) {
            flag := 1
            For index, value in word_array {
                ;MsgBox word_array2[index]
                if (word_array[index] != word_array2[index]) {
                    if (index != word_array.length) {
                        flag := 0
                        break
                    }
                    if (InStr(word_array2[index], word_array[index]) != 1) { ;InStr=1意味着在开头第一个字符就匹配了
                        flag := 0
                        break
                    }
                }
            }
            if (flag == 1) {
                return [1, this_id, this_title]
            }
        }
    }
    return [0, '', '']
}

name := "D:\my_repo\my_cmd\ahk_scipt\cache\1_haha.ahk" ;可以传参
DetectHiddenWindows 1
ahk_list := WinGetList("ahk_class AutoHotkey")
result := compare(name, ahk_list) ;cacheFullScript
;MsgBox result[1]
;MsgBox result[2]
;MsgBox result[3]
if (result[1] == 1) {
    MsgBox result[3]
    WinClose "ahk_id " result[2]
}

exit
ListVars
Pause
