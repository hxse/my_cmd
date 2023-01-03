Set-PSDebug -Trace 1
cd E:\
python  -m pyftpdlib -p 21 --username=$env:ftpName --password=$env:ftpPassword
Set-PSDebug -Trace 0
