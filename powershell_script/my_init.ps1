# 用powershell如下调用来初始化工作空间
# in windows terminal: powershell -NOLogo -NoExit -File "D:\my_repo\my_cmd\powershell_script\my_init.ps1"
# 如果出现乱码,就打开windows的系统设置,找到"更改系统区域设置",打开"Beta 版: 使用 Unicode UTF-8 提供全球语言支持"(这个可能导致打不开文华财经,谨慎使用)
# 乱码是因为ps5默认不是utf8,把脚本文件编码改成utf8dom可以解决,或者把中文写到配置文件里,也可以解决,检查ps版本`$PSVersionTable.PSVersion`
# 把这个加入vscode的配置文件,默认新建ps1时就会是utf8bom了"[powershell]": {"files.encoding": "utf8bom", "files.autoGuessEncoding": true}
# 编写ps1脚本时要注意, $null = $arr4.Add($a), 必须得有个$null, 不然函数返回就会有莫名其妙的值, 这点很坑, 恶心但没办法, 只能注意了, https://stackoverflow.com/questions/24548723/clear-captured-output-return-value-in-a-powershell-function
# 如果函数函数返回一个: return @( @(), $new_arr) 调用函数用 $null, $v = Func1 | select -Last 2
# 如果函数返回格式多个: return @( $new_arr, $new_arr2) 调用函数用 $v, $v2 = Func1 | select -Last 2
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
# chcp 65001#解决中文乱码

echo "my_init.ps1 loading..."

$startup = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
$scriptPath = $MyInvocation.MyCommand.Definition
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$assetsDir = $scriptDir + '\assets'
$localDir = Get-Location

. "$scriptDir\tool.ps1"
. "$scriptDir\init_script\handle_parameters.ps1"
. "$scriptDir\init_script\plugin.ps1"
. "$scriptDir\init_script\basic_command.ps1"
. "$scriptDir\init_script\media_command.ps1"
. "$scriptDir\init_script\app_command.ps1"
. "$scriptDir\init_script\pyfire_command.ps1"

. "$scriptDir\init_script\feud_command.ps1"
