$proxy = "--proxy", "127.0.0.1:7890"
$cf = "--concurrent-fragments", "10"
$video = "--no-playlist"
$playlist = "--yes-playlist"
$da = "--download-archive", "archive.txt"
$da = ""
$ws = "--write-subs"
$was = "--write-auto-subs"
$langs = "--sub-langs", "en,en-*,en-GB,en-en,en-us,zh-CN,zh-TW,zh-HK,ja,-live_chat"#all
$cs = "--convert-subs", "srt"
$outVideo = "-o", "`"%(uploader)s/_videos/%(upload_date)s %(id)s/%(upload_date)s %(title)s %(id)s.%(ext)s`""
$outPlaylist = "-o", "`"%(uploader)s/%(playlist)s %(playlist_id)s/%(upload_date)s %(id)s/%(upload_date)s %(title)s %(id)s.%(ext)s`""
$meta = "title,playlist,playlist_id,uploader,upload_date,id,ext"
$replace = "--replace-in-metadata", $meta, "\&", "_"
$replace2 = "--replace-in-metadata", $meta, "$([System.Text.Encoding]::UTF8.GetString(([byte]226, 128, 147)))", "_" #替换全角减号
#$replace2 = "--replace-in-metadata", $meta, "\-", "_" #替换全角减号
$replace3 = "--replace-in-metadata", $meta, "\?", "_" #替换全角问号
$replace4 = "--replace-in-metadata", $meta, "\:", "_" #替换全角冒号
$replaceMetadata = $replace + $replace2 + $replace3 + $replace4  # 这里一定要用加号, 不能用逗号, 因为replace,和replace2都已经是参数了
$replaceMetadata = ""
$audio = "--extract-audio", "--audio-format", "mp3"
$embed = "--no-embed-thumbnail", "--embed-metadata"#,"--embed-subs"#--embed-thumbnail嵌入封面会导致ffmpeg后续处理不了报错 Invalid data found when processing input
$cookie = ""#"--cookies-from-browser","chrome"
$ytDownload = "D:\my_repo\parrot_fashion\download"
$overWrite = "--force-overwrites"
$justJson = "--write-info-json --skip-download"
$wirteJson = "--write-info-json"

$fullSubtract = "$([System.Text.Encoding]::UTF8.GetString(([byte]226, 128, 147)))"#全角减号

Function yva {
    $n = 2
    if ($Args.Count -lt $n) {
        echo "至少$n`个参数: url, archivePath"
        return
    }

    $dir = Get-Location;
    cd $ytDownload;
    $a = "--download-archive", "`"$($args[1])`"", "`"$($args[0])`"", ( (skipArgsQuote $args 2 ))
    $command = "yt-dlp $proxy $cf $ws $was $langs $cs $embed $cookie $video $outVideo $audio $replaceMetadata $overWrite $wirteJson $a";
    echo $command
    iex $command
    cd $dir
}

Function ypa {
    $n = 2
    if ($Args.Count -lt $n) {
        echo "至少$n`个参数,url,archivePath"
        return
    }

    $localDir = Get-Location;
    cd $ytDownload;
    $a = "--download-archive", "`"$($args[1])`"", "`"$($args[0])`"", ( (skipArgsQuote $args 2 ))
    $command = "yt-dlp $proxy $cf $ws $was $langs $cs $embed $cookie $playlist $outPlaylist $audio $replaceMetadata $overWrite $wirteJson $a"
    echo $command
    iex $command
    cd $dir
}

function ypa_bbc {
    $url = "https://www.youtube.com/playlist?list=PLcetZ6gSk96-FECmH9l7Vlx5VDigvgZpt"
    $archive = "BBC Learning English/6 Minute English - Vocabulary & listening PLcetZ6gSk96-FECmH9l7Vlx5VDigvgZpt.txt"
    ypa $url $archive
}

function ypa_kur {
    $url = "https://www.youtube.com/@kurzgesagt"
    $archive = "Kurzgesagt – In a Nutshell/_videos.txt"
    ypa $url $archive
}

function ypa_bs {
    $url = "https://www.youtube.com/@besmart"
    $archive = "Be Smart/_videos.txt"
    ypa $url $archive
}

function _lw($argsArr, $def_argsStr  ) {
    # 合并默认参数和用户参数, 返回str格式
    $aArr, $kArr = getParam  $argsArr  | select -Last 2
    $def_aArr, $def_kArr = getParam  $def_argsStr  | select -Last 2
    $new_aArr, $new_kArr = mergerArgsStr $aArr $kArr $def_aArr $def_kArr  | select -Last 2

    $localDir = Get-Location;
    cd "D:\my_repo\parrot_fashion\crawler"
    $command = "pdm run python loop_whisper.py loop $new_aArr $new_kArr"
    echo $command
    iex $command
    cd $dir
}

function lw {
    $n = 1
    if ($Args.Count -lt $n) {
        echo "至少$n`个参数: dirPath"
        return
    }

    $dirPath = "" #手动覆盖
    $offset = "--start-offset 200 --end-offset 200 --over-start 0 --over-end 0"
    $operate = "--operate-mode en_no_comma"
    $whisperName = "--whisper-name wc2"
    $import = "--import-anki 0"
    $release = "--enable-release-apkg 0"
    $ankiPath = "--anki-app `"$env:USERPROFILE\AppData\Local\Programs\Anki\anki.exe`""
    $prompt = "--initial-prompt `"Please, listen to dialogue and question. the example question one: What is the color of this apple? Is it, a red, b green, c yellow? the example question two: What kind of transportation did he take?  Was it, a car, b bike, c bus? A final note, pay attention to the use of punctuation.`""
    $def_args = "$dirPath 1 1 1  --skip 0 --check 0 $operate  $offset  $whisperName $import $release $ankiPath $prompt"

    _lw $args $def_args
}

function lw_bbc {
    # 用例: lw_bbc
    # 覆盖: lw_bbc "D:\my_repo\parrot_fashion\download\BBC Learning English" 0 --check 1
    # $prompt里面别用双引号了,  可能有转义问题, powershell转义是`",但是whisper转义是"",很奇怪,算了,别用就行了
    $dirPath = "`"D:\my_repo\parrot_fashion\download\BBC Learning English`""
    $offset = "--start-offset 200 --end-offset 200 --over-start 0 --over-end 0"
    $operate = "--operate-mode en_no_comma"
    $whisperName = "--whisper-name wc2"
    $import = "--import-anki 0"
    $release = "--enable-release-apkg 0"
    $ankiPath = "--anki-app `"$env:USERPROFILE\AppData\Local\Programs\Anki\anki.exe`""
    $prompt = "--initial-prompt `"Please, listen to dialogue and question. the example question one: What is the color of this apple? Is it, a red, b green, c yellow? the example question two: What kind of transportation did he take?  Was it, a car, b bike, c bus? A final note, pay attention to the use of punctuation.`""
    # $prompt = "--initial-prompt `"what the fuck is the apple? \\\```"or is the banana?\\\```" i don't know`""# python 需要用\"转义
    $def_args = "$dirPath 1 1 1  --skip 0 --check 0 $operate  $offset  $whisperName $import $release $ankiPath $prompt"

    _lw $args $def_args
}


function lw_kur {
    # 用例: lw_bbc
    # 覆盖: lw_bbc "D:\my_repo\parrot_fashion\download\BBC Learning English" 0 --check 1

    $dirPath = "`"D:\my_repo\parrot_fashion\download\Kurzgesagt – In a Nutshell`""
    $offset = "--start-offset 200 --end-offset 200 --over-start 0 --over-end 0"
    $operate = "--operate-mode en_no_comma"
    $whisperName = "--whisper-name wc2"
    $import = "--import-anki 0"
    $release = "--enable-release-apkg 0"
    $ankiPath = "--anki-app `"$env:USERPROFILE\AppData\Local\Programs\Anki\anki.exe`""
    $prompt = "--initial-prompt `"Please, listen to dialogue and question. the example question one: What is the color of this apple? Is it, a red, b green, c yellow? the example question two: What kind of transportation did he take?  Was it, a car, b bike, c bus? A final note, pay attention to the use of punctuation.`""
    $def_args = "$dirPath 1 1 1  --skip 0 --check 0 $operate  $offset  $whisperName $import $release $ankiPath $prompt"

    _lw $args $def_args
}


function lw_bs {
    # 用例: lw_bbc
    # 覆盖: lw_bbc "D:\my_repo\parrot_fashion\download\BBC Learning English" 0 --check 1

    $dirPath = "`"D:\my_repo\parrot_fashion\download\Be Smart`""
    $offset = "--start-offset 200 --end-offset 200 --over-start 0 --over-end 0"
    $operate = "--operate-mode en_no_comma"
    $whisperName = "--whisper-name wc2"
    $import = "--import-anki 0"
    $release = "--enable-release-apkg 0"
    $ankiPath = "--anki-app `"$env:USERPROFILE\AppData\Local\Programs\Anki\anki.exe`""
    $prompt = "--initial-prompt `"Please, listen to dialogue and question. the example question one: What is the color of this apple? Is it, a red, b green, c yellow? the example question two: What kind of transportation did he take?  Was it, a car, b bike, c bus? A final note, pay attention to the use of punctuation.`""
    $def_args = "$dirPath 1 1 1  --skip 0 --check 0 $operate  $offset  $whisperName $import $release $ankiPath $prompt"

    _lw $args $def_args
}


function z_dh {
    cd "D:\my_repo\parrot_fashion\crawler"
    pdm run python loop_whisper.py loop "D:\my_repo\parrot_fashion\download\影视\绝望主妇" "0" "0" "0" --skip "0" --operate-mode "en_no_comma" --anki-app "$env:USERPROFILE\AppData\Local\Programs\Anki\anki.exe" --enable_zip "1"
}

function m_dh {
    cd "D:\my_repo\parrot_fashion\crawler"
    pdm run python .\loop_whisper.py mzf 'D:\my_repo\parrot_fashion\download\影视\绝望主妇' "$env:USERPROFILE\Downloads\srs file" -regex="^.*(S01).*zip$"  -stemStart 0 -stemEnd -1
}


function z_bbc {
    cd "D:\my_repo\parrot_fashion\crawler"
    pdm run python loop_whisper.py loop "D:\my_repo\parrot_fashion\download\BBC Learning English" "0" "0" "0" --skip "0" --operate-mode "en_no_comma" --anki-app "$env:USERPROFILE\AppData\Local\Programs\Anki\anki.exe" --enable_zip "1"
}

function  m_bbc {
    cd "D:\my_repo\parrot_fashion\crawler"
    pdm run python .\loop_whisper.py mzf 'D:\my_repo\parrot_fashion\download\BBC Learning English' "$env:USERPROFILE\Downloads\srs file" -regex="^.*2023(0[123456]).*zip$"  -stemStart 0 -stemEnd -1
}


function z_kur {
    cd "D:\my_repo\parrot_fashion\crawler"
    pdm run python loop_whisper.py loop "D:\my_repo\parrot_fashion\download\Kurzgesagt  In a Nutshell\Kurzgesagt  In a Nutshell - Videos UCsXVk37bltHxD1rDPwtNM8Q" "0" "0" "0" --skip "0" --operate-mode "en_no_comma" --anki-app "$env:USERPROFILE\AppData\Local\Programs\Anki\anki.exe" --enable_zip "1"
}

function m_kur {
    cd "D:\my_repo\parrot_fashion\crawler"
    pdm run python .\loop_whisper.py mzf 'D:\my_repo\parrot_fashion\download\Kurzgesagt  In a Nutshell\Kurzgesagt  In a Nutshell - Videos UCsXVk37bltHxD1rDPwtNM8Q' "$env:USERPROFILE\Downloads\srs file" -regex="^.*2022(0[123456789]|1[012]).*zip$"  -stemStart 0 -stemEnd -1
}


function z_bs {
    cd "D:\my_repo\parrot_fashion\crawler"
    pdm run python loop_whisper.py loop "D:\my_repo\parrot_fashion\download\Be Smart\Be Smart - Videos UCH4BNI0-FOK2dMXoFtViWHw" "0" "0" "0" --skip "0" --operate-mode "en_no_comma" --anki-app "$env:USERPROFILE\AppData\Local\Programs\Anki\anki.exe" --enable_zip "1"
}

function m_bs {
    cd "D:\my_repo\parrot_fashion\crawler"
    pdm run python .\loop_whisper.py mzf 'D:\my_repo\parrot_fashion\download\Be Smart\Be Smart - Videos UCH4BNI0-FOK2dMXoFtViWHw' "$env:USERPROFILE\Downloads\srs file" -regex="^.*2022(0[123456789]|1[012]).*zip$"  -stemStart 0 -stemEnd -1
}

function xmly {
    $loopTime = 60 * 60 * 24
    $sleepTime = 60 * 40
    cd "D:\App\download\ximalaya_downloader"

    if ($args -like "-*" ) {
        node xmd.js $args
    }
    else {
        for ($i = 0; $i -lt $loopTime; $i++) {
            node xmd.js -a $args
            echo "下载完成后用这个命令合并: py_ff concatAudio"
            echo '用这个命令转换格式: py_ff convertDir --inSuffix ".mp4" --outSuffix ".m4a" "dirPath"'
            echo Get-Date "sleep $sleepTime"
            Start-Sleep $sleepTime
        }
    }

}

function missav {
    cd "$env:USERPROFILE\Downloads"
    miyuki -ffmpeg -urls $args
}

function missav_plist {
    cd "$env:USERPROFILE\Downloads"
    miyuki -ffmpeg -plist $args
}
