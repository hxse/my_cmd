from simple_fire import simple_fire
from tool import r_add_quota_warp
import subprocess


def loop_whisper(
    dirPath,
    enable1=1,
    enable2=1,
    enable3=1,
    skip=0,
    check=0,
    operate="en_no_comma",
    start_offset=200,
    end_offset=200,
    over_start=0,
    over_end=0,
    whisperName="wc2",
    import_anki=0,
    release=0,
    ankiPath=r"C:\Users\hxse\AppData\Local\Programs\Anki\anki.exe",
    prompt="Hello, welcome to my lecture. Separate sentences with punctuation symbols, use punctuation symbols to shorten sentences, mandatory use of punctuation symbols.",
):
    dirPath = r_add_quota_warp(dirPath)
    ankiPath = r_add_quota_warp(ankiPath)
    prompt = r_add_quota_warp(prompt)
    command = f"pdm run python loop_whisper.py loop {dirPath} {enable1} {enable2} {enable3} --skip {skip} --check {check} "
    command += f"--operate-mode {operate} --start-offset {start_offset} --end-offset {end_offset} --over-start {over_start} --over-end {over_end} "
    command += f"--whisper-name {whisperName} --import-anki {import_anki} --enable-release-apkg {import_anki} --anki-app {ankiPath} --initial-prompt {prompt}"
    print(command)
    cwd = "D:\my_repo\parrot_fashion\crawler"
    subprocess.run(command, cwd=cwd)


def loop_whisper_bbc(
    *args,
    **kargs,
):
    dirPath = "D:\my_repo\parrot_fashion\download\BBC Learning English"
    loop_whisper(dirPath, *args, **kargs)


def loop_whisper_kur(
    *args,
    **kargs,
):
    dirPath = "D:\my_repo\parrot_fashion\download\Kurzgesagt – In a Nutshell\Kurzgesagt – In a Nutshell - Videos UCsXVk37bltHxD1rDPwtNM8Q"
    loop_whisper(dirPath, *args, **kargs)


def loop_whisper_bs(
    *args,
    **kargs,
):
    dirPath = "D:\my_repo\parrot_fashion\download\Be Smart\Be Smart - Videos UCH4BNI0-FOK2dMXoFtViWHw"
    loop_whisper(dirPath, *args, **kargs)


def loop_whisper_dh(
    *args,
    **kargs,
):
    dirPath = "D:\my_repo\parrot_fashion\download\影视\绝望主妇"
    loop_whisper(dirPath, *args, **kargs)


if __name__ == "__main__":
    simple_fire(
        {
            "py_lw": loop_whisper,
            "py_lw_bbc": loop_whisper_bbc,
            "py_lw_kur": loop_whisper_kur,
            "py_lw_bs": loop_whisper_bs,
            "py_lw_dh": loop_whisper_dh,
        }
    )
