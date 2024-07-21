import sys, os

sys.path.append(
    os.path.dirname(os.path.abspath(__file__)) + "/.."
)  # import tool from parent dir
from tool import r_add_quota
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


if __name__ == "__main__":
    simple_fire(
        {
            "convertFile": convertFile,
            "convertDir": convertDir,
            "reduceVideo": reduceVideo,
            "reduceDir": reduceDir,
            "audioVolume": audioVolume,
            "audioVolumeDir": audioVolumeDir,
        }
    )
