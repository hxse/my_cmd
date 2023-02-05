#!/usr/bin/env python3
# coding: utf-8
import os, subprocess

proxy = "--proxy 127.0.0.1:7890"
cf = "--concurrent-fragments 10"
video = "--no-playlist"
playlist = "--yes-playlist"
da = "--download-archive archive.txt"
da = ""
ws = "--write-subs"
was = "--write-auto-subs"
langs = "--sub-langs en,en-*,en-GB,en-en,en-us,zh-CN,zh-TW,zh-HK,ja,-live_chat"  # all
cs = "--convert-subs srt"
outVideo = '-o "%(uploader)s/_videos/%(upload_date)s %(id)s/%(upload_date)s %(title)s %(id)s.%(ext)s"'

outPlaylist = '-o "%(uploader)s/%(playlist)s %(playlist_id)s/%(upload_date)s %(id)s/%(upload_date)s %(title)s %(id)s.%(ext)s"'

meta = "title,playlist,playlist_id,uploader,upload_date,id,ext"
replace = f'--replace-in-metadata {meta} "\&" "_"'
replace = ""
audio = "--extract-audio --audio-format mp3"
embed = "--no-embed-thumbnail --embed-metadata"  # ,"--embed-subs"#--embed-thumbnail嵌入封面会导致ffmpeg后续处理不了报错 Invalid data found when processing input
cookie = ""  # "--cookies-from-browser","chrome"
ytDownload = r"D:\my_repo\parrot_fashion\download"
overWrite = "--force-overwrites"


def test_command(*args, **kargs):
    print(args, kargs)


def ydl_playlist_audio(cwd, *args, **kargs):
    # download playlist
    archive = kargs["--download-archive"]
    archive = f'--download-archive "{archive}"'
    command = f"yt-dlp {proxy} {cf} {ws} {was} {langs} {cs} {embed} {cookie} {playlist} {outPlaylist} {audio} {replace} {overWrite} {archive} {args[0]}"
    print(command)
    subprocess.run(command, cwd=cwd)


def ydl_video_audio(cwd, *args, **kargs):
    # download all videos
    archive = kargs["--download-archive"]
    archive = f'--download-archive "{archive}"'
    command = f"yt-dlp {proxy} {cf} {ws} {was} {langs} {cs} {embed} {cookie} {video} {outVideo} {audio} {replace} {overWrite} {archive} {args[0]}"
    print(command)
    subprocess.run(command, cwd=cwd)


command_obj = {
    "test_command": test_command,
    "ydl_playlist_audio": ydl_playlist_audio,
    "ydl_video_audio": ydl_video_audio,
}
