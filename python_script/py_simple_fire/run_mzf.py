import sys, os

sys.path.append(
    os.path.dirname(os.path.abspath(__file__)) + "/.."
)  # import tool from parent dir
from tool import r_add_quota_warp
from simple_fire import simple_fire
import subprocess


def merger_zip_file(dirPath, outDir, regex=".*", stemStart=0, stemEnd=-1):
    dirPath = r_add_quota_warp(dirPath)
    outDir = r_add_quota_warp(outDir)
    regex = r_add_quota_warp(regex)
    command = rf"pdm run python .\loop_whisper.py mzf {dirPath} {outDir} -regex {regex} -stemStart {stemStart} -stemEnd {stemEnd}"
    cwd = rf"D:\my_repo\parrot_fashion\crawler"
    print(command)
    subprocess.run(command, cwd=cwd)


def merger_zip_file_bbc(regex, *args, **kargs):
    """
    --regex "^.*2023(0[123456789]|1[012]).*zip$"
    """
    dirPath = rf"D:\my_repo\parrot_fashion\download\BBC Learning English"
    outDir = rf"C:\Users\hxse\Downloads\srs file"
    merger_zip_file(dirPath, outDir, regex=regex, *args, **kargs)


def merger_zip_file_kur(regex, *args, **kargs):
    """
    --regex "^.*2023(0[123456789]|1[012]).*zip$"
    """
    dirPath = rf"D:\my_repo\parrot_fashion\download\Kurzgesagt – In a Nutshell\Kurzgesagt – In a Nutshell - Videos UCsXVk37bltHxD1rDPwtNM8Q"
    outDir = rf"C:\Users\hxse\Downloads\srs file"
    merger_zip_file(dirPath, outDir, regex=regex, *args, **kargs)


def merger_zip_file_bs(regex, *args, **kargs):
    """
    --regex "^.*2023(0[123456789]|1[012]).*zip$"
    """
    dirPath = rf"D:\my_repo\parrot_fashion\download\Be Smart\Be Smart - Videos UCH4BNI0-FOK2dMXoFtViWHw"
    outDir = rf"C:\Users\hxse\Downloads\srs file"
    merger_zip_file(dirPath, outDir, regex=regex, *args, **kargs)


def merger_zip_file_dh(regex, *args, **kargs):
    """
    --regex "^.*(S01).*zip$"
    """
    dirPath = rf"D:\my_repo\parrot_fashion\download\影视\绝望主妇"
    outDir = rf"C:\Users\hxse\Downloads\srs file"
    merger_zip_file(dirPath, outDir, regex=regex, *args, **kargs)


if __name__ == "__main__":
    simple_fire(
        {
            "mzf": merger_zip_file,
            "mzf_bbc": merger_zip_file_bbc,
            "mzf_kur": merger_zip_file_kur,
            "mzf_bs": merger_zip_file_bs,
            "mzf_dh": merger_zip_file_dh,
        }
    )
