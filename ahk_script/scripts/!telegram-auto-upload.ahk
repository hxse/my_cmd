#Requires AutoHotkey >=2.0
sleepTime := 250
F3::
{

    skipCopyEnter := InputBox("skipCopyEnter", "is skip copy name and skip enter", "", 0).value
    skipCopyName := InputBox("skipCopyName", "is skip copy name", "", 0).value
    skipCopyFullName := InputBox("skipCopyFullName", "is skip copy full name", "", 1).value
    loopNum := InputBox("loopNum", "loop number", "", 0).value

    If (loopNum = 0)
    {
        Return
    }

    Sleep 2000

    Loop loopNum
    {
        Send "^{c}"
        Sleep sleepTime

        Send "!{TAB}"
        Sleep sleepTime

        Send "^{v}"
        Sleep sleepTime


        If (skipCopyEnter = 0)
        {
            If (skipCopyName = 0)
            {
                Send "!{TAB}"
                Sleep sleepTime

                Send "{F2}"
                Sleep sleepTime

                If (skipCopyFullName = 0)
                {
                    Send "^{a}"
                    Sleep sleepTime
                }
                Send "^{c}"
                Sleep sleepTime
            }

            Send "!{TAB}"
            Sleep sleepTime

            Send "^{v}"
            Sleep sleepTime

            Send "{Enter}"
            Sleep sleepTime
        }

        Send "!{TAB}"
        Sleep sleepTime

        Send "{Down}"
        Sleep sleepTime
    }
}

F12::
{
    Loop
    {
        Click
        Sleep sleepTime

        Send "^{Enter}"
        Sleep sleepTime
    }
}

F4:: Reload

F5:: ExitApp

F6:: Pause
