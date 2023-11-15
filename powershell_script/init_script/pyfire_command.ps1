

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


function py_lw {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_lw.py" py_lw $args
}


function py_lw_bbc {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_lw.py" py_lw_bbc $args
}

function py_lw_kur {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_lw.py" py_lw_kur $args
}

function py_lw_bs {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_lw.py" py_lw_bs $args
}

function py_lw_dh {
    # 替换参数示例: py_ypa_bbc newUrl --proxy '--proxy \"new proxy\"'
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_lw.py" py_lw_dh $args
}

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


function py_ff {
    # use ffmpeg for media file
    cd "D:\my_repo\my_cmd\python_script"
    pdm run python "D:\my_repo\my_cmd\python_script\py_simple_fire\run_ffmpeg.py" $args
}
