import sys, os
from pathlib import Path

sys.path.append(
    os.path.dirname(os.path.abspath(__file__)) + "/.."
)  # import tool from parent dir
from tool import r_add_quota
from simple_fire import simple_fire
import subprocess


def get_kargs(kargs):
    command = ""
    _k = [(k, v) for k, v in kargs.items()]
    for k, v in _k:
        k = f"-{k}" if len(k) == 1 else f"--{k}"
        command += f" {k} {v}"
    return command


def ytdl_playlist_audio(
    url,
    archive,
    proxy='--proxy "127.0.0.1:7890"',  # 直接在命令行输入 --proxy '--proxy \"127.0.0.1 7890\"', 或者用r_add_quota转换,添加双引\号
    cf="--concurrent-fragments 10",
    ws="--write-subs",
    was="--write-auto-subs",
    langs='--sub-langs "en,en-*,en-GB,en-en,en-us,zh-CN,zh-TW,zh-HK,ja,-live_chat"',  # al
    cs="--convert-subs srt",
    embed="--no-embed-thumbnail --embed-metadata",  # ,"--embed-subs"#--embed-thumbnail嵌入封面会导致ffmpeg后续处理不了报错 Invalid data found when processing inpu
    cookie="",  # "--cookies-from-browser","chrome
    video="yes-playlist",
    outVideo='-o "%(uploader)s/_videos/%(upload_date)s %(id)s/%(upload_date.0:4)s/%(upload_date)s %(id)s.%(ext)s"',
    outPlaylist='-o "%(uploader)s/%(playlist)s %(playlist_id)s/%(upload_date.0:4)s/%(upload_date)s %(id)s/%(upload_date)s %(id)s.%(ext)s"',
    audio="--extract-audio --audio-format mp3",
    replaceMetadata="",  # "--replace-in-metadata", "title,playlist,playlist_id,uploader,upload_date,id,ext", "\-", "_" #替换全角减
    overWrite="--force-overwrites",
    wirteJson="--write-info-json",
    cwd=r"D:/my_repo/parrot_fashion/download",
    dateafter="",
    max_downloads="",
    exe=Path.home() / "scoop/apps/yt-dlp/current/yt-dlp.exe",
    enable_gpu='--postprocessor-args "-c:v h265_nvenc"',
    enable_subtitle=True,
    *args,
    **kargs,
):
    if enable_subtitle in ["0", 0, None, "False", False]:
        ws = ""
        was = ""
        langs = ""
        cs = ""
        embed = ""
    video = f"--{video}"
    archive = r_add_quota(f"--download-archive {archive}")
    # proxy = r_add_quota(proxy)
    ws = "--write-subs" if was else ""
    outVideo = outPlaylist
    command = f'"{exe}" {url} {archive}'
    command += f" {proxy} {cf} {ws} {was} {langs} {cs}"
    command += f" {embed} {cookie} {video} {outVideo} {audio}"
    command += f" {replaceMetadata} {overWrite} {wirteJson}"
    command += f" {dateafter} {max_downloads}"
    command += f" {enable_gpu}"
    command += get_kargs(kargs)
    print(command)
    subprocess.run(command, cwd=cwd)


def ytdl_playlist_audio_title(
    url,
    archive,
    outVideo='-o "%(uploader)s/_videos/%(upload_date)s %(id)s/%(upload_date.0:4)s/%(upload_date)s %(title)s.%(ext)s"',
    outPlaylist='-o "%(uploader)s/%(playlist)s %(playlist_id)s/%(upload_date.0:4)s/%(upload_date)s %(id)s/%(upload_date)s %(title)s.%(ext)s"',
    *args,
    **kargs,
):
    ytdl_playlist_audio(
        url, archive, outVideo=outVideo, outPlaylist=outPlaylist, *args, **kargs
    )


def ytdl_playlist_audio_bbc(
    url="https://www.youtube.com/playlist?list=PLcetZ6gSk96-FECmH9l7Vlx5VDigvgZpt",
    archive="BBC Learning English/6 Minute English - Vocabulary & listening PLcetZ6gSk96-FECmH9l7Vlx5VDigvgZpt.txt",
    *args,
    **kargs,
):
    ytdl_playlist_audio(url, archive, *args, **kargs)


def ytdl_playlist_audio_kur(
    url="https://www.youtube.com/@kurzgesagt",
    archive="Kurzgesagt – In a Nutshell/_videos.txt",
    *args,
    **kargs,
):
    ytdl_playlist_audio(url, archive, *args, **kargs)


def ytdl_playlist_audio_bs(
    url="https://www.youtube.com/@besmart",
    archive="Be Smart/_videos.txt",
    *args,
    **kargs,
):
    ytdl_playlist_audio(url, archive, *args, **kargs)


def ytdl_playlist_audio_wb(
    url="https://www.youtube.com/@wisdombread",
    archive="Wisdom Bread 智慧麵包/Wisdom Bread 智慧麵包.txt",
    *args,
    **kargs,
):
    ytdl_playlist_audio(url, archive, *args, **kargs)


def ytdl_playlist_audio_vt(
    url="https://www.youtube.com/@veritasium",
    archive="Veritasium/Veritasium.txt",
    *args,
    **kargs,
):
    ytdl_playlist_audio(url, archive, *args, **kargs)


def ytdl_playlist_audio_ted(
    url="https://www.youtube.com/@TED",
    archive="TED/TED.txt",
    *args,
    **kargs,
):
    ytdl_playlist_audio(
        url,
        archive,
        # dateafter="--dateafter 20230101",
        max_downloads="--max-downloads 1",
        *args,
        **kargs,
    )


if __name__ == "__main__":
    # todo "ypa_bbc": [ytdl_playlist_audio, "bbc_url", "bbc_archive"]
    simple_fire(
        {
            "ypa": ytdl_playlist_audio,
            "ypa_title": ytdl_playlist_audio_title,
            "ypa_bbc": ytdl_playlist_audio_bbc,
            "ypa_kur": ytdl_playlist_audio_kur,
            "ypa_bs": ytdl_playlist_audio_bs,
            "ypa_wb": ytdl_playlist_audio_wb,
            "ypa_vt": ytdl_playlist_audio_vt,
            "ypa_ted": ytdl_playlist_audio_ted,
        }
    )
