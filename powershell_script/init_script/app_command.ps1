
function g {
    # python terminal gui
    cd D:\my_repo\my_cmd\python_script;
    pdm run python .\prompt_toolkit_demo\mian.py $args
}
Function js {
    $localDir = Get-Location;
    cd "D:\my_repo\94_crawler"
    pdm run python ".\94.py" md --outPath "F:/91porn" $args
    cd $localDir
}

Function jable {
    $localDir = Get-Location;
    cd "D:\my_repo\JableTVDownload"
    pdm run python "D:\my_repo\JableTVDownload\main.py" --outPath "E:\jable download" --tempDir "$env:USERPROFILE\Downloads\jable temp" $args;
    pdm run python .\get_info.py ld;
    cd $localDir
}


Function cydb {
    $biliPath = "D:\bilibili"
    cd "D:\my_repo\bilibili-crawler";
    $data2 = (pdm run python main.py gb $args[0]);
    $data = $data2 | ConvertFrom-Json;
    echo $data.data;
    echo $data.count;
    $data.data | ForEach { ydb $_.url };
    #$data| ConvertFrom-Json |Select -ExpandProperty data|ForEach {ydb $_.url};
}


Function tuf { python "D:\my_repo\tg-upload\tg_upload.py" uf $args }
Function tud { python "D:\my_repo\tg-upload\tg_upload.py" ud $args }


# $cwaDir = "D:\App\proxy\clash-web-app"
# Function cwa { & $cwaDir\cwa.bat $args }
# Function cwas { cat $cwaDir\config\config.json | jq '.origin' }

# don't use this, use py_ff

Function cut_mp4 {
    #ffmpeg command
    $files = Get-ChildItem ".\"
    foreach ($f in $files) {
        $outFile = $f.BaseName + "_out" + $f.Extension
        echo $outFile
        #echo $f.BaseName
        #echo $f.Extension
        #echo $f.Name
        ffmpeg -i $f.Name -ss 00:00:05 -avoid_negative_ts 1  -avoid_negative_ts make_zero -c copy $outFile
        break
    }
}
Function reduceVideoSize {
    #ffmpeg command
    $files = Get-ChildItem ".\"
    foreach ($f in $files) {
        #$outFile = $f.BaseName + "_out" + $f.Extension
        $outFile = $f.BaseName + "_out" + ".mp4"
        $size = $f.length / 1024 / 1024 / 1024
        $threshold = 1.97
        if ($size -gt $threshold) {
            echo "$size > $threshold name: $f.$Name"
            #ffmpeg -i $f -fs 1970M -c copy $outFile #这个只会截取一部分时长
            ffmpeg -i $f -vcodec libx265 -crf 24 $outFile
        }
        else {
            echo "$size <= $threshold name: $f.$Name"
        }
        #echo $f.BaseName
        #echo $f.Extension
        #echo $f.Name
        #break
    }
}

Function crop_ffmpeg {
    #ffmpeg command
    $files = Get-ChildItem ".\"
    foreach ($f in $files) {
        $outFile = $f.BaseName + ".mp4"
        $size = $f.length / 1024 / 1024 / 1024
        $threshold = 1.97
        ffmpeg -i $f  -fs 1970M -filter:v "crop=1024:660:000:400" $outFile
    }
}


Function f2mp4 {
    #ffmpeg command ts -> mp4
    $file = $args[0]
    $outFile = $file + '.mp4'
    ffmpeg -i "$file" -acodec copy -vcodec copy "$outFile"
}

Function f2mp3 {
    #ffmpeg command ts -> mp3
    # $file = $args[0]
    # $outFile = $file + '.mp3'
    # ffmpeg -i "$file" -acodec copy -vcodec copy "$outFile"
    if ($args.Count -eq 1) {
        Write-Host "1"
        convert_file $args[0] ".mp3"
    }
    if ($args.Count -eq 2) {
        Write-Host "2"
        convert_file $args[0] $args[1]
    }
}


Function convert_dir {
    #ffmpeg command ts -> mp3 from dir
    if (!$args[0]) {
        Write-Host "args[0] is null"
        return
    }

    $files = get-childitem $args[0] -Recurse
    foreach ($f in $files) {
        $outFile = $f.DirectoryName + "\" + $f.BaseName + ".mp4"
        if (!$f.PSIsContainer) {
            if (('.mkv', '.avi', '.rmvb', '.flv', '.mov').contains(($f).Extension)) {
                $name = ($f).FullName
                ffmpeg -i "$name" "$outFile"
            }
        }
    }
}


Function d2mp4 {
    #ffmpeg command ts -> mp3 from dir
    if (!$args[0]) {
        Write-Host "args[0] is null"
        return
    }

    $files = get-childitem $args[0] -Recurse
    foreach ($f in $files) {
        $outFile = $f.DirectoryName + "\" + $f.BaseName + ".mp4"
        if (!$f.PSIsContainer) {
            if (('.mkv', '.avi', '.rmvb', '.flv', '.mov').contains(($f).Extension)) {
                $name = ($f).FullName
                ffmpeg -i "$name" "$outFile"
            }
        }
    }
}


Function d2mp3 {
    #ffmpeg command ts -> mp3 from dir
    if (!$args[0]) {
        Write-Host "args[0] is null"
        return
    }

    $files = get-childitem $args[0] -Recurse
    foreach ($f in $files) {
        $outFile = $f.DirectoryName + "\" + $f.BaseName + ".mp3"
        if (!$f.PSIsContainer) {
            if (('.mp4', '.mkv', '.avi', '.rmvb', '.flv', '.mov').contains(($f).Extension)) {
                $name = ($f).FullName
                ffmpeg -i "$name" "$outFile"
            }
        }
    }
}
