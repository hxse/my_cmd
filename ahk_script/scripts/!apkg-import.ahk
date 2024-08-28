#Requires AutoHotkey >=2.0
F3::
{
    loopNum := InputBox("loopNum", "loop number", "", 0).value

    Loop loopNum
    {
        Sleep 200
        Send "{Enter}"
        Sleep 2000

        Send "!{TAB}"
        Sleep 200

        Send "!{TAB}"
        Sleep 200
        
        Sleep 1000
        Send "^{Enter}"
        
        Sleep 1000
        Send "{Esc}"
        
        Send "!{TAB}"
        Sleep 200
        
        Send "{Down}"
        Sleep 200
        
    }
}


F4:: ExitApp

F5::Pause
