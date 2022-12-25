chcp 65001
cd D:\my_repo\my_cmd
set /p c=请输入commit:
git add .
git commit -m "%c%"
git push https://hxse:%hxse_github_token%@github.com/hxse/my_cmd.git
pause