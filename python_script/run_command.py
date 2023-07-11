import fire
import subprocess
from dataclasses import dataclass


def ytdl_playlist_audio(
    url,
    archive,
    proxy="--proxy 127.0.0.1:7890",  # 命令行传参时用 --proxy '""--proxy lkj""', 用simple fire的和, 可以'\"127.0.0.1 7890\"'  ,这样更接近python原本的转义模式
    ws="--write-subs",
    *args,
    **kargs,
):
    # proxy = "--proxy 127.0.0.1:7890"
    # cf = "--concurrent-fragments 10"
    # ws = "--write-subs"
    # was = "--write-auto-subs"
    # langs = (
    #     "--sub-langs en,en-*,en-GB,en-en,en-us,zh-CN,zh-TW,zh-HK,ja,-live_chat",
    # )  # al
    # cs = "--convert-subs srt"
    # embed = (
    #     "--no-embed-thumbnail --embed-metadata",
    # )  # ,"--embed-subs"#--embed-thumbnail嵌入封面会导致ffmpeg后续处理不了报错 Invalid data found when processing inpu
    # cookie = ("",)  # "--cookies-from-browser","chrome
    # video = "--yes-playlist"
    # outVideo = '-o "%(uploader)s/_videos/%(upload_date)s %(id)s/%(upload_date)s %(title)s %(id)s.%(ext)s"'
    # audio = "--extract-audio --audio-format mp3"
    # replaceMetadata = (
    #     "",
    # )  # "--replace-in-metadata", "title,playlist,playlist_id,uploader,upload_date,id,ext", "\-", "_" #替换全角减
    # overWrite = "--force-overwrites"
    # wirteJson = "--write-info-json"
    # cwd = "D:/my_repo=parrot_fashion/download"

    # print(f"args {args}")
    # print(f"kargs {kargs}")
    # url, archive = args

    # args_str = " ".join([f'"{i}"' for i in args])
    # kargs_str = " ".join([f'--{k} "{kargs[k]}"' for k in kargs.keys()])
    # command = f"{url} --download-archive {archive} {proxy} {args_str} {kargs_str}"
    command = f"{url} --download-archive {archive} {proxy}"
    print(command)
    # subprocess.run(command, cwd=cwd)
    return


# @decorator_name
def ytdl_playlist_audio_bbc(
    url="https://www.youtube.com/playlist?list=PLcetZ6gSk96-FECmH9l7Vlx5VDigvgZpt",
    archive="BBC Learning English/6 Minute English - Vocabulary & listening PLcetZ6gSk96-FECmH9l7Vlx5VDigvgZpt.txt",
    *args,
    **kargs,
):
    print(args)
    print(kargs)
    return ytdl_playlist_audio(url, archive, *args, **kargs)
    # def_args = [url, archive, "hello", "world", "skip"]
    # def_kargs = {"check": "1"}
    # new_args = (
    #     [*args, *def_args[len(args) - 1 :]] if len(args) < len(def_args) else args
    # )
    # new_kargs = {**def_kargs, **kargs}
    # return ytdl_playlist_audio(*new_args, **new_kargs)


# @dataclass
class ytdl_playlist_audio_class(object):
    def __init__(
        self,
        proxy="--proxy 127.0.0.1:7890",
        cf="--concurrent-fragments 10",
        ws="--write-subs",
        was="--write-auto-subs",
        langs="--sub-langs en,en-*,en-GB,en-en,en-us,zh-CN,zh-TW,zh-HK,ja,-live_chat",  # al
        cs="--convert-subs srt",
        embed="--no-embed-thumbnail --embed-metadata",  # ,"--embed-subs"#--embed-thumbnail嵌入封面会导致ffmpeg后续处理不了报错 Invalid data found when processing inpu
        cookie="",  # "--cookies-from-browser","chrome
        video="--yes-playlist",
        outVideo='-o "%(uploader)s/_videos/%(upload_date)s %(id)s/%(upload_date)s %(title)s %(id)s.%(ext)s"',
        audio="--extract-audio --audio-format mp3",
        replaceMetadata="",  # "--replace-in-metadata", "title,playlist,playlist_id,uploader,upload_date,id,ext", "\-", "_" #替换全角减
        overWrite="--force-overwrites",
        wirteJson="--write-info-json",
        cwd="D:/my_repo=parrot_fashion/download",
    ):
        self.def_command = f"{proxy} {cf} {ws} {was} {langs} {cs}"
        self.def_command += f"{embed} {cookie} {video} {outVideo} {audio}"
        self.def_command += f"{replaceMetadata} {overWrite} {wirteJson} {cwd}"

    def bbc(
        self,
        url="https://www.youtube.com/playlist?list=PLcetZ6gSk96-FECmH9l7Vlx5VDigvgZpt",
        archive="BBC Learning English/6 Minute English - Vocabulary & listening PLcetZ6gSk96-FECmH9l7Vlx5VDigvgZpt.txt",
    ):
        command = f"{url} --download-archive {archive} {self.def_command}"
        print(command)
        # subprocess.run(command, cwd=cwd)


def test(a: str, b: str):
    print(a, b)


if __name__ == "__main__":
    fire.Fire(
        {
            "py_ypa_bbc": ytdl_playlist_audio_bbc,
            "ypa": ytdl_playlist_audio_class,
            "t": test,
        }
    )
