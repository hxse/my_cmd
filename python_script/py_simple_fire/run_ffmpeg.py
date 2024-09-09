import sys, os

sys.path.append(
    os.path.dirname(os.path.abspath(__file__)) + "/.."
)  # import tool from parent dir
from tool import convert2d, convert2dIndex, z_fill
from simple_fire import simple_fire
import subprocess
from pathlib import Path


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


def concatAudio(
    dirPath,
    inputSuffix=".m4a",
    outputSuffix=".mp3",
    sort_mode="default",
    step=10,
    *args,
    **kargs,
):
    arr = []
    for i in Path(dirPath).glob(f"*{inputSuffix}"):
        if i.parent.name == "_cache":
            continue
        if i.suffix == ".txt":
            continue
        if i.name.startswith("!"):
            continue
        arr.append(i)

    if sort_mode == "default":
        arr = sorted(arr, key=lambda x: int(x.name.split(".")[0]))

    for [start, end] in convert2dIndex(len(arr), step):
        n = len(f"{len(arr)}")
        inputPath = (
            Path(dirPath)
            / "_cache"
            / f"input {  z_fill(start+1,n)} {z_fill(end,n)}.txt"
        )
        _outPath = (
            Path(dirPath)
            / "_cache"
            / f"output {z_fill(start+1,n)} {z_fill(end,n)}{inputSuffix}"
        )
        outPath = _outPath.parent / (_outPath.stem + outputSuffix)
        outPath.parent.mkdir(parents=True, exist_ok=True)

        if outPath.is_file() and outPath.stat().st_size > 0 and not _outPath.is_file():
            print(f"skip {outPath}")
            continue

        with open(inputPath, "w", encoding="utf8") as f:
            f.writelines([f"file '../{i.name}'\n" for i in arr[start:end]])

        command = f'ffmpeg -f concat -safe 0 -i "{inputPath}" -c copy "{_outPath}"'
        print(command)
        subprocess.run(command, cwd=dirPath)

        if inputSuffix != outputSuffix:
            command = f'ffmpeg -i "{_outPath}" "{outPath}"'
            print(command)
            subprocess.run(command, cwd=dirPath)
        if outPath.is_file():
            _outPath.unlink(missing_ok=True)


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
            "convert2d": convert2d,
            "convert2dIndex": convert2dIndex,
        }
    )
