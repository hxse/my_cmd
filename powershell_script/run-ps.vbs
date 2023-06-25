' https://github.com/PowerShell/PowerShell/issues/3028#issuecomment-974628397
Set shell = CreateObject("WScript.Shell")
For Each arg In WScript.Arguments
    shell.Run("powershell -windowstyle hidden -executionpolicy bypass -noninteractive -command ""&"" ""'" & arg & "'"""),0
Next
