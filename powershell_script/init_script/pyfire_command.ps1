﻿

function py_yva {
    # 替换参数示例: py_ypa newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ypa.py" ypa $args --video "no-playlist"
}

function py_ypa {
    # 替换参数示例: py_ypa newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ypa.py" ypa $args
}

function py_yva_title {
    # 替换参数示例: py_ypa newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ypa.py" ypa_title $args --video "no-playlist"
}


function py_ypa_title {
    # 替换参数示例: py_ypa newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ypa.py" ypa_title $args
}

function py_ypa_bbc {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ypa.py" ypa_bbc $args
}


function py_ypa_kur {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ypa.py" ypa_kur $args
}


function py_ypa_bs {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ypa.py" ypa_bs $args
}


function py_ypa_wb {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ypa.py" ypa_wb $args
}


function py_ypa_vt {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ypa.py" ypa_vt $args
}

# function py_ypa_ted {
#     # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
# 视频太多了,还是手动下吧
#     cd "D:\my_repo\my_cmd\python_script"
#     pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ypa.py" ypa_ted $args
# }

function loop_anki {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\parrot_fashion\recorder"
    uv run python loop.py loop $args
}

function py_gs {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\parrot_fashion\recorder"
    $archiveDir = "D:\BaiduNetdiskDownload\人人存档\字幕备份"
    $archiveCsv = "D:\BaiduNetdiskDownload\人人存档\人人影视字幕查询总表(2012-2024)_IT豪哥整理.csv"
    uv run python .\get_srt.py gs --archiveDir $archiveDir --archiveCsv $archiveCsv $args
}

function py_as {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\parrot_fashion\recorder"
    uv run python .\get_srt.py as $args
}


function py_as_dir {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\parrot_fashion\recorder"
    uv run python .\get_srt.py as_dir $args
}

function tts_anki {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\parrot_fashion\recorder"
    uv run python tts_deck.py $args
}

# function py_lw {
#     # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
#     cd "D:\my_repo\my_cmd\python_script"
#     pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_lw.py" py_lw $args
# }

# function py_lw_ja {
#     # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
#     cd "D:\my_repo\my_cmd\python_script"
#     pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_lw.py" py_lw --lang ja $args
# }


# function py_lw_bbc {
#     # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
#     cd "D:\my_repo\my_cmd\python_script"
#     pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_lw.py" py_lw_bbc $args
# }

# function py_lw_kur {
#     # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
#     cd "D:\my_repo\my_cmd\python_script"
#     pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_lw.py" py_lw_kur $args
# }

# function py_lw_bs {
#     # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
#     cd "D:\my_repo\my_cmd\python_script"
#     pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_lw.py" py_lw_bs $args
# }

# function py_lw_dh {
#     # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
#     cd "D:\my_repo\my_cmd\python_script"
#     pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_lw.py" py_lw_dh $args
# }

# function py_lw_vt {
#     # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
#     cd "D:\my_repo\my_cmd\python_script"
#     pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_lw.py" py_lw_vt $args
# }

function py_mzf {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_mzf.py" mzf $args
}

function py_mzf_bbc {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_mzf.py" mzf_bbc $args
}

function py_mzf_kur {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_mzf.py" mzf_kur $args
}

function py_mzf_bs {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_mzf.py" mzf_bs $args
}

function py_mzf_dh {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_mzf.py" mzf_dh $args
}

function py_av {
    # use audio volume
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ffmpeg.py" audioVolume $args
}

function py_avd {
    # use audio volume
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ffmpeg.py" audioVolumeDir $args
}

function py_ff {
    # use ffmpeg for media file
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ffmpeg.py" $args
}


function py_tool {
    # use ffmpeg for media file
    $p = $PWD
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_tool.py" $args --output_file "$p\output.txt"
    cd $p
}
