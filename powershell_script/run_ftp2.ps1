function e {
    cd F:\
    python  -m pyftpdlib -p 23 --username=$env:ftpName --password=$env:ftpPassword
}
Set-PSDebug -Trace 1
e
Set-PSDebug -Trace 0
