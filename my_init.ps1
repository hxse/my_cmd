# 用powershell如下调用来初始化工作空间
# powershell.exe -noexit '. D:\\Note\\02-Computer\\program\\my_init.ps1'
# in windows terminal: powershell -noexit '. C:\Users\hxse\Downloads\my_init.ps1'
# 如果出现乱码,就打开windows的系统设置,找到"更改系统区域设置",打开"Beta 版: 使用 Unicode UTF-8 提供全球语言支持"
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

$biliPath="D:\bilibili"
Function ydb {
yt-dlp -o $biliPath\"%(uploader)s/%(upload_date)s %(playlist)s/%(title)s %(id)s.%(ext)s"  -i $args[0] 
}

Function cydb {
cd "D:\my_repo\bilibili-crawler";
$data2 = (pdm run python main.py gb $args[0]);
$data=  $data2 | ConvertFrom-Json;
echo $data.data;
echo $data.count;
$data.data|ForEach {ydb $_.url};
#$data| ConvertFrom-Json |Select -ExpandProperty data|ForEach {ydb $_.url};
} 


# 已弃用: 下载单个视频的时候, yva {油管网址链接} -> ysts {本地字幕文件链接} -> yats {本地字幕文件链接}
# 不要上面那个麻烦的了,yva {油管网址链接} -> ycs {本地英文字幕文件链接}

$proxy="--proxy","127.0.0.1:7890"
$cf="--concurrent-fragments","10"
$video="--no-playlist"
$playlist="--yes-playlist"
$da="--download-archive","archive.txt"
$ws="--write-subs"
$was="--write-auto-subs"
$langs="--sub-langs","en,en-*,en-GB,en-en,en-us,zh-CN,zh-TW,zh-HK,ja,-live_chat"#all
$cs="--convert-subs","srt"
$outVideo="-o","%(uploader)s/videos/%(upload_date)s %(id)s/%(upload_date)s %(title)s %(id)s.%(ext)s"
$outPlaylist="-o","%(uploader)s/%(playlist)s %(playlist_id)s/%(upload_date)s %(title)s %(id)s.%(ext)s"
$audio="--extract-audio","--audio-format","mp3"
$embed="--embed-thumbnail","--embed-metadata"#,"--embed-subs"
$cookie=""#"--cookies-from-browser","chrome"
$ytDownload="D:\my_repo\parrot_fashion\download"

Function ylp { #gen anki,这个需要手动输入audioPath,srtPath,srt2Path,可以根据实际情况,再写个批处理脚本,来使用这个命令
$dir=Get-Location;
cd "D:\my_repo\parrot_fashion\crawler";
$dict = @{ 
	ku = $ytDownload+"\Kurzgesagt – In a Nutshell"#中间的–不是-,所以会有莫名其妙的bug,换成中文其实也会乱码,,解决方法是,在windows设置里找到"区域设置",然后找到"更改系统区域设置,打开"Beta 版: 使用 Unicode UTF-8 提供全球语言支持""
}
pdm run python loop.py $args[0] $dict[$args[0]] 直接写在代码里吧,不要写在这了
cd $dir
}
Function yga { #gen anki,这个需要手动输入audioPath,srtPath,srt2Path,可以根据实际情况,再写个批处理脚本,来使用这个命令
$dir=Get-Location;
cd "D:\my_repo\parrot_fashion\crawler";
$audioPath=$args[0];
$srtPath=$args[1];
$srtPath2=$args[2];
pdm run python gen_anki.py ga $audioPath $srtPath $srtPath2
cd $dir
}
Function ycs { #clean srt 
$dir=Get-Location;
cd "D:\my_repo\parrot_fashion\crawler";
$inPath=$args[0];
$outPath="$inPath.txt.srt";
echo 'format srt:'$inPath;
ysts $inPath;
echo 'translate srt:'$outPath;
yats $outPath;
cd $dir
}
Function yats { #translate srt srt
$dir=Get-Location;
cd "D:\my_repo\parrot_fashion\crawler";
& pdm run python D:\my_repo\parrot_fashion\crawler\autosub_tool.py ats $args;
cd $dir
}
Function yts {
$dir=Get-Location;
cd "D:\my_repo\parrot_fashion\crawler";
& pdm run python D:\my_repo\parrot_fashion\crawler\loop_trans_srt.py ts --dirPath $ytDownload $args;
cd $dir
}
Function yfs {# srt format to txt to srt
$dir=Get-Location;
cd "D:\my_repo\parrot_fashion\crawler";
& pdm run python D:\my_repo\parrot_fashion\crawler\format.py lp $ytDownload $args;
cd $dir
}
Function yfst {yfs;yts;}
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

Function yxt{#txt to srt
			C:\Python37-32\python.exe -m aeneas.tools.execute_task $args[0] $args[1]   "task_language=eng|os_task_file_format=srt|is_text_type=plain" $args[2]}
			
Function ysts {#格式化字幕, srt to txt to srt
$dir=Get-Location;
cd "D:\my_repo\parrot_fashion\crawler";
& pdm run python D:\my_repo\parrot_fashion\crawler\format.py sts $args;
cd $dir
}

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
pdm run python "D:\my_repo\JableTVDownload\main.py" --outPath "E:\jable download" --tempDir "C:\Users\hxse\Downloads\jable temp" $args;
cd $dir
}

$startup="C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
echo "workspace is inited"

