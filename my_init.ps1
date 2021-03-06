# 用powershell如下调用来初始化工作空间
# powershell.exe -noexit '. D:\\Note\\02-Computer\\program\\my_init.ps1'
# in windows terminal: powershell -noexit '. C:\Users\hxse\Downloads\my_init.ps1'
#chcp 65001

$ompPath= "C:\Users\hxse\scoop\apps\oh-my-posh\current\themes"
oh-my-posh init pwsh | Invoke-Expression
oh-my-posh --init --shell pwsh --config $ompPath\kali2.omp.json | Invoke-Expression #预览参考: https://ohmyposh.dev/docs/themes

$scriptPath = $MyInvocation.MyCommand.Definition
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$assetsDir= $scriptDir+'\assets'
$dir=Get-Location
echo $assetsDir

# For zoxide v0.8.0+
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

# For older versions of zoxide
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell) -join "`n"
})

Function nfp {netstat -aon|findstr $args[0]}
Function tfp {tasklist|findstr $args[0]}
Function tkp {taskkill /T /F /PID $args[0]}
Function sd { Shutdown -s -t 30 }

$ytw=[regex]::Unescape("\u4ee5\u592a\u7f51")#以太网三个字的的unicode
$mip = Get-NetIPAddress |  where IPAddress -like '192.168.*' | where InterfaceAlias -like $ytw | select  -ExpandProperty "IPAddress"
Function mip{$mip}


Function cvr { yarn create vite $args[0] --template react;
				cd $args[0];
				yarn;
				}
Function cvt { yarn create vite $args[0] --template react-ts;
				cd $args[0];
				yarn;
				}
Function cvtw { yarn create vite $args[0] --template react-ts;
				cd $args[0];
				yarn;
				# https://tailwindcss.com/docs/guides/vite
				$name=$args[0]
				yarn add -D tailwindcss postcss autoprefixer;
				npx tailwindcss init -p;
				Copy-Item -Path $assetsDir'\cvtw\tailwind.config.js' -Destination $dir\$name\'tailwind.config.js'
				Copy-Item -Path $assetsDir'\cvtw\index.css' -Destination $dir\$name\'src\index.css'
				Copy-Item -Path $assetsDir'\cvtw\App.tsx' -Destination $dir\$name\'src\App.tsx'
				
				 #(Get-Content ".\tailwind.config.js" | Out-String) -replace "content: \[]", "content:[`r`n    `"./index.html`",`r`n    `"./src/**/*.{vue,js,ts,jsx,tsx}`",`r`n  ]" | Out-File ".\tailwind.config.js";
				 #"@tailwind base;@tailwind components;@tailwind utilities;"-replace ";", ";`r`n"|Out-File ".\src\index.css";
				 #(Get-Content ".\src\App.tsx" | Out-String ) -replace "(?sm)return \(.*\)", "return (`r`n    <h1 className=`"text-3xl font-bold underline`">`r`n      Hello world!`r`n    </h1>`r`n  )" | Out-File ".\src\App.tsx";
				}


$cwaDir="D:\App\proxy\clash-web-app"
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
cd "D:\my_repo\parrot_fashion\crawler";
& pdm run python D:\my_repo\parrot_fashion\crawler\loop_trans_srt.py ts --dirPath $ytDownload $args;
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

Function js { 
	$dir=Get-Location;
	cd "D:\my_repo\94_crawler"
	pdm run python ".\94.py" md --outPath "E:/91porn" $args
	cd $dir
	}

Function jable {
$dir=Get-Location;
cd "D:\my_repo\JableTVDownload"
pdm run python "D:\my_repo\JableTVDownload\main.py" --outPath "E:\jable download" $args;
cd $dir
}

$startup="C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
echo "workspace is inited"

