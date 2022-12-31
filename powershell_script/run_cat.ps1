Set-PSDebug -Trace 1
echo "cat $args"
cat $args -Encoding UTF8
Set-PSDebug -Trace 0
