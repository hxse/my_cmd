Set shell = CreateObject("WScript.Shell")
For Each arg In WScript.Arguments
    shell.Run("powershell -windowstyle hidden -executionpolicy bypass -noninteractive -command ""&"" ""'" & arg & "'"""),0
Next