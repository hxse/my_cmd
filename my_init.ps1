# 用powershell如下调用来初始化工作空间
# powershell.exe -noexit '. D:\\Note\\02-Computer\\program\\my_init.ps1'
# in windows terminal: powershell -noexit '. C:\Users\hxse\Downloads\my_init.ps1'

$scriptPath = $MyInvocation.MyCommand.Definition
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$dir=Get-Location


Function nfp {netstat -aon|findstr $args[0]}
Function tfp {tasklist|findstr $args[0]}
Function tkp {taskkill /T /F /PID $args[0]}
Function sd { Shutdown -s -t 30 }

Function cvr { yarn create vite $args[0] --template react }
Function cvt { npx degit joaopaulomoraes/reactjs-vite-tailwindcss-boilerplate $args[0]}

$cwaDir="E:\App\proxy\clash-web-app"
Function cwa { & $cwaDir\cwa.bat $args}
Function cwas {  cat $cwaDir\config\config.json | jq '.origin' }


Function tuf { python "D:\my_repo\tg-upload\tg_upload.py" uf $args}
Function tud { python "D:\my_repo\tg-upload\tg_upload.py" ud $args}

$proxy="--proxy","127.0.0.1:7890"
$cf="--concurrent-fragments","10"
$video="--no-playlist"
$playlist="--yes-playlist"
$da="--download-archive","archive.txt"
$ws="--write-subs"
$was="--write-auto-subs"
$langs="--sub-langs","en,en-us,zh-CN,zh-TW,zh-HK,ja,-live_chat"#all
$cs="--convert-subs","srt"
$outVideo="-o","%(uploader)s/videos/%(upload_date)s %(title)s %(id)s.%(ext)s"
$outPlaylist="-o","%(uploader)s/%(playlist)s %(playlist_id)s/%(upload_date)s %(title)s %(id)s.%(ext)s"
$audio="--extract-audio","--audio-format","mp3"
$embed="--embed-thumbnail","--embed-metadata"#,"--embed-subs"
$cookie=""#"--cookies-from-browser","chrome"
$ytDownload="D:\my_repo\parrot_fashion\download"
Function yts {
$dir=Get-Location;
cd $ytDownload; 
& python D:\my_repo\parrot_fashion\crawler\loop_trans_srt.py --dirPath $ytDownload $args;
cd $dir
}
Function yvv { 
$dir=Get-Location;
cd $ytDownload; 
& yt-dlp $proxy $cf $da $ws $was $langs $cs $embed $cookie $video $outVideo $args;
cd $dir
}
Function yvvt{yvv $args;yts $args;}
Function yva {
$dir=Get-Location;
cd $ytDownload; 
& yt-dlp $proxy $cf $da $ws $was $langs $cs $embed $cookie $video $outVideo $audio $args;
cd $dir
}
Function yvat{yva $args;yts $args;}
Function ypv {
$dir=Get-Location;
cd $ytDonload; 
& yt-dlp $proxy $cf $da $ws $was $langs $cs $embed $cookie $playlist $outPlaylist $args;
cd $dir
}
Function ypvt{ypv $args;yts $args;}
Function ypa {
$dir=Get-Location;
cd $ytDownload; 
& yt-dlp $proxy $cf $da $ws $was $langs $cs $embed $cookie $playlist $outPlaylist $audio $args;
cd $dir
}
Function ypat{ypa $args;yts $args;}

Function ti { python "D:\Note\02-Computer\program\python\python-repo\color-filter\cf.py" ti $args }
Function pi { python "D:\Note\02-Computer\program\python\python-repo\color-filter\cf.py" pi $args }

Function js { powershell "E:\91porn\run_94.bat" $args}

Function jable {
$dir=Get-Location;
cd "E:\jable download"; 
python "D:\my_repo\JableTVDownload\main.py" $args;
cd $dir
}

$startup="C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
echo "workspace is inited"

