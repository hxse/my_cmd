import sys, os

sys.path.append(os.path.dirname(os.path.abspath(__file__)) +
                "/..")  # import tool from parent dir
from tool import r_add_quota
from simple_fire import simple_fire
import subprocess


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
    outVideo='-o "%(uploader)s/_videos/%(upload_date)s %(id)s/%(upload_date.0:4)s/%(upload_date)s %(title)s %(id)s.%(ext)s"',
    outPlaylist='-o "%(uploader)s/%(playlist)s %(playlist_id)s/%(upload_date.0:4)s/%(upload_date)s %(id)s/%(upload_date)s %(title)s %(id)s.%(ext)s"',
    audio="--extract-audio --audio-format mp3",
    replaceMetadata="",  # "--replace-in-metadata", "title,playlist,playlist_id,uploader,upload_date,id,ext", "\-", "_" #替换全角减
    overWrite="--force-overwrites",
    wirteJson="--write-info-json",
    cwd=r"D:/my_repo/parrot_fashion/download",
):
    video = f"--{video}"
    archive = r_add_quota(f"--download-archive {archive}")
    # proxy = r_add_quota(proxy)
    ws = "--write-subs" if was else ""
    outVideo = outPlaylist
    exe = r'"D:/App/app/yt-dlp/yt-dlp.exe"'
    command = f"{exe} {url} {archive}"
    command += f" {proxy} {cf} {ws} {was} {langs} {cs}"
    command += f" {embed} {cookie} {video} {outVideo} {audio}"
    command += f" {replaceMetadata} {overWrite} {wirteJson}"
    print(command)
    subprocess.run(command, cwd=cwd)


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


if __name__ == "__main__":
    # todo "ypa_bbc": [ytdl_playlist_audio, "bbc_url", "bbc_archive"]
    simple_fire({
        "ypa": ytdl_playlist_audio,
        "ypa_bbc": ytdl_playlist_audio_bbc,
        "ypa_kur": ytdl_playlist_audio_kur,
        "ypa_bs": ytdl_playlist_audio_bs,
    })
