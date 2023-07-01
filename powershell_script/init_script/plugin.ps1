
# scoop install starship
# Invoke-Expression (&starship init powershell)

# $zLua = "D:\my_repo\my_cmd\lua_script\z.lua\z.lua"
# echo $zLua
# Invoke-Expression (& { (lua $zLua --init powershell) -join "`n" })

#$ompPath= "C:\Users\hxse\scoop\apps\oh-my-posh\current\themes"
#oh-my-posh init pwsh | Invoke-Expression
#oh-my-posh --init --shell pwsh --config $ompPath\kali2.omp.json | Invoke-Expression #预览参考: https://ohmyposh.dev/docs/themes

#Import-Module PSReadLine
#Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
#Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward



Invoke-Expression (& { (zoxide init powershell | Out-String) })
