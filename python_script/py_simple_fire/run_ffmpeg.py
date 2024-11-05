import sys, os

sys.path.append(
    os.path.dirname(os.path.abspath(__file__)) + "/.."
)  # import tool from parent dir
from tool import convert2d, convert2dIndex, z_fill
from simple_fire import simple_fire
import subprocess
from pathlib import Path
import shutil
import hashlib


def indexOf(value, array):
    try:
        return array.index(value)
    except ValueError:
        return -1


def check_arg(i):
    return i not in [False, "False", 0, "0", None, "None", ""]


def audioVolume(filePath, db="10dB", overFile=False):
    """
    filePath: input file path
    db: 3dB, -3dB
    overFile: bool
    """
    filePath = Path(filePath)
    outPath = filePath.parent / ("_" + filePath.name)
    command = f'ffmpeg -i "{filePath}"  -vcodec copy -af "volume={db}" "{outPath}"'
    print(command)
    subprocess.run(command, cwd=filePath.parent)
    if overFile:
        Path(outPath).replace(filePath)


def audioVolumeDir(dirPath, db="10dB", overFile=False, suffix=".mp3"):
    """
    dirPath: input dir path
    db: 3dB, -3dB
    overFile: bool
    """
    for i in Path(dirPath).glob("**/*"):
        if i.suffix == suffix:
            print(i.suffix)
            audioVolume(
                i,
                db=db,
                overFile=overFile,
            )


def convertFile(filePath, outSuffix=".mp3", enableCopy=True):
    filePath = Path(filePath)
    outPath = filePath.parent / (filePath.stem + outSuffix)
    command = f'ffmpeg -i "{filePath}" {"-vn" if outSuffix==".ogg" else ""} {"-acodec copy -vcodec copy" if enableCopy in [True, "1", 1] else ""} "{outPath}"'
    print(command)
    subprocess.run(command, cwd=filePath.parent)


def convertDir(dirPath, inSuffix=".mp4", outSuffix=".mp3", enableCopy=True):
    """
    convert all file in dir
    """
    dirPath = Path(dirPath)
    for i in dirPath.glob("**/*"):
        if i.suffix == inSuffix:
            convertFile(i, outSuffix=outSuffix, enableCopy=enableCopy)


def reduceVideo(filePath, size=1.97):
    filePath = Path(filePath)
    outPath = filePath.parent / (filePath.stem + "_temp_out" + filePath.suffix)

    fileSize = filePath.stat().st_size / 1024 / 1024 / 1024
    if size < fileSize:
        command = (
            f"ffmpeg -i {filePath} -vcodec libx265 -crf 24 -preset ultrafast {outPath}"
        )
        subprocess.run(command, cwd=filePath.parent)


def reduceDir(dirPath, suffix=".mp4"):
    dirPath = Path(dirPath)
    for i in dirPath.glob("**/*"):
        if i.suffix == suffix and "_temp_out" not in i.name:
            reduceVideo(i)


def clear_duplication(arr):
    """
    清理文件名相同但扩展名不同的重复文件,比如test.mp4 test.m4a, 会比较大小, 然后留下最大的文件
    """
    history_stem = []
    history_path = []
    for i in arr:
        num = indexOf(i.stem, history_stem)
        if num == -1:
            history_stem.append(i.stem)
            history_path.append([i])
        else:
            history_path[num].append(i)

    for _arr in history_path:
        if len(_arr) > 1:
            _arr = [[i, i.stat().st_size] for i in _arr]
            _p = max(_arr, key=lambda x: x[1])
            _res = [i for i in _arr if _p[0] != i[0]]
            for _path, _size in _res:
                _path.unlink(missing_ok=True)


def get_md5(name):
    hash_md5 = hashlib.md5()
    with open(name, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()


def check_repeat(arr):
    """
    清除大小为0的文件
    清除大小相同的重复文件
    """

    def check(path, obj, data):
        data[obj] = [*data.get(obj, []), path]
        return [len(data[obj]) > 1, data[obj]]

    d = {}
    for path in arr:
        if path.is_dir():
            continue
        size = path.stat().st_size
        if size == 0:
            raise RuntimeError(f"有大小为0的文件 {path}")

        size_flag, size_list = check(path, path.stat().st_size, d)
        if size_flag:
            # path_list = "\n".join([i.as_posix() for i in size_list])
            # raise RuntimeError(f"检测到大小相同的重复文件\n{path_list}")
            d2 = {}
            for _p in size_list:
                md5_flag, md5_list = check(_p, get_md5(_p), d2)
                if md5_flag:
                    path_list = "\n".join([i.as_posix() for i in md5_list])
                    raise RuntimeError(f"检测到md5相同的重复文件\n{path_list}")


def concatAudio(
    dirPath,
    name="output",
    inputSuffix="[.m4a,.mp4]",
    cacheSuffix=".aac",
    outputSuffix=".m4a",
    enableCacheCopy=True,
    enableOutputCopy=True,
    sort_mode="default",
    step=10,
    clearCache=True,
    clearMode=False,
    *args,
    **kargs,
):
    """
    cacheSuffix=".aac",
    outputSuffix=".mp3",
    enableCacheCopy=True,
    enableOutputCopy=False,
    ----
    cacheSuffix=".aac",
    outputSuffix=".m4a",
    enableCacheCopy=True,
    enableOutputCopy=True,
    """
    arr = []
    for i in Path(dirPath).glob(f"*{inputSuffix}"):
        if i.parent.name == "_cache":
            continue
        if i.parent.name == "_output":
            continue
        if i.suffix == ".txt":
            continue
        if i.name.startswith("!"):
            continue
        arr.append(i)

    if sort_mode == "default":
        _s = " " if arr[0].name.count(".") == 1 else "."
        arr = sorted(arr, key=lambda x: int(x.name.split(_s)[0]))

    if check_arg(clearMode):
        clear_duplication(arr)
        return

    check_repeat(arr)

    for [start, end] in convert2dIndex(len(arr), step):
        n = len(f"{len(arr)}")
        inputPath = (
            Path(dirPath) / "_log" / f"input {  z_fill(start+1,n)} {z_fill(end,n)}.txt"
        )
        outPath = (
            Path(dirPath)
            / "_output"
            / f"{name} {z_fill(start+1,n)} {z_fill(end,n)}{outputSuffix}"
        )
        cachePath = Path(dirPath) / "_cache"
        inputPath.parent.mkdir(parents=True, exist_ok=True)
        outPath.parent.mkdir(parents=True, exist_ok=True)
        cachePath.mkdir(parents=True, exist_ok=True)

        if outPath.is_file() and outPath.stat().st_size > 0:
            print(f"skip {outPath}")
            continue

        def getCacheFilePath(i):
            return cachePath / (f"{i.stem}{cacheSuffix}")

        with open(inputPath, "w", encoding="utf8") as f:
            for i in range(start, end):
                cacheNamePath = getCacheFilePath(arr[i])
                f.write(f"file '../_cache/{cacheNamePath.name}'\n")

        for i in range(start, end):
            cacheInPath = Path(dirPath) / arr[i].name
            cacheNamePath = getCacheFilePath(arr[i])
            if cacheInPath.name == cacheNamePath.name:
                shutil.copy(cacheInPath, cacheNamePath)
            else:
                command = f'ffmpeg -i "{cacheInPath}" {"-c:a copy" if check_arg(enableCacheCopy) else ""} "{cacheNamePath}"'
                print(command)
                subprocess.run(command, cwd=dirPath)

        command = f'ffmpeg -f concat -safe 0 -i "{inputPath}" {"-c:a copy" if check_arg(enableOutputCopy) else ""} "{outPath}"'
        print(command)
        subprocess.run(command, cwd=dirPath)

        if outPath.is_file() and check_arg(clearCache):
            for i in range(start, end):
                cacheNamePath = getCacheFilePath(arr[i])
                cacheNamePath.unlink(missing_ok=True)


def splitVideo(
    inputPath,
    segment="00:40:00",
    *args,
    **kargs,
):
    command = f"ffmpeg -i {inputPath} -c copy -map 0 -segment_time {segment} -f segment  -reset_timestamps 1 -segment_start_number 1 {inputPath}_%02d.mp4"
    print(command)
    subprocess.run(command)


if __name__ == "__main__":
    simple_fire(
        {
            "convertFile": convertFile,
            "convertDir": convertDir,
            "reduceVideo": reduceVideo,
            "reduceDir": reduceDir,
            "audioVolume": audioVolume,
            "audioVolumeDir": audioVolumeDir,
            "concatAudio": concatAudio,
            "splitVideo": splitVideo,
            "convert2d": convert2d,
            "convert2dIndex": convert2dIndex,
        }
    )
