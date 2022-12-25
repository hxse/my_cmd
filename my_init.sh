# C:\Users\hxse\scoop\apps\git\current\bin\bash.exe  --login -i -c '"D:\my_repo\my_cmd\my_init.sh"'
export mypath=$(dirname $0)
export myname=$(basename $0)
export my="sdf"
echo ${mypath}
echo $myname
echo $my
exec bash
