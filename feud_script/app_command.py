import feud
import subprocess


def merge_command(command):
    return " ".join([f'"{i}"' if " " in i else i for i in command])


def convert_file(inputFile, outSuffix=".mp3", enableCopy=True):
    outFile = inputFile + outSuffix
    if enableCopy:
        command = [
            "ffmpeg",
            "-i",
            f"{inputFile}",
            "-acodec",
            "copy",
            "-vcodec",
            "copy",
            f"{outFile}",
        ]
    else:
        command = [
            "ffmpeg",
            "-i",
            f"{inputFile}",
            f"{outFile}",
        ]
    print(merge_command(command))
    subprocess.run(command)


def test(hello, world="haha"):
    print(hello, world)


if __name__ == "__main__":
    feud.run({"cf": convert_file, "test": test})
