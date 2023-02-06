#!/usr/bin/env python3
# coding: utf-8
import os, subprocess
from urllib.parse import urlparse, parse_qs
from pathlib import Path

proxy = "--proxy 127.0.0.1:7890"
cf = "--concurrent-fragments 10"
video = "--no-playlist"
playlist = "--yes-playlist"
da = "--download-archive archive.txt"
da = ""
ws = "--write-subs"
was = "--write-auto-subs"
langs = "--sub-langs en,en-*,en-GB,en-en,en-us,zh-CN,zh-TW,zh-HK,ja,-live_chat"  # all
nolangs = "--sub-langs ''"  # all
cs = "--convert-subs srt"
outVideo = '-o "%(uploader)s/_videos/%(upload_date)s %(id)s/%(upload_date)s %(title)s %(id)s.%(ext)s"'

outPlaylist = '-o "%(uploader)s/%(playlist)s %(playlist_id)s/%(upload_date)s %(id)s/%(upload_date)s %(title)s %(id)s.%(ext)s"'
# outPlaylist,这个会因为title太长,导致超出windows260字符限制,所以不要用了,用outPlaylistJson配合writeJson

meta = "title,playlist,playlist_id,uploader,upload_date,id,ext"
replace = f'--replace-in-metadata {meta} "\&" "_"'
replace = ""
audio = "--extract-audio --audio-format mp3"
embed = "--no-embed-thumbnail --embed-metadata"  # ,"--embed-subs"#--embed-thumbnail嵌入封面会导致ffmpeg后续处理不了报错 Invalid data found when processing input
cookie = ""  # "--cookies-from-browser","chrome"
ytDownload = r"D:\my_repo\parrot_fashion\download"
overWrite = "--force-overwrites"

justJson = "--write-info-json --skip-download"
wirteJson = "--write-info-json"
outPlaylistJson = '-o "%(uploader)s/%(playlist)s %(playlist_id)s/%(upload_date)s %(id)s/%(upload_date)s %(id)s.%(ext)s"'
outVideoJson = (
    '-o "%(uploader)s/_videos/%(upload_date)s %(id)s/%(upload_date)s %(id)s.%(ext)s"'
)


def test_command(cwd, *args, **kargs):
    print(cwd, args, kargs)


def ydl_playlist_audio(cwd, *args, **kargs):
    # download playlist
    _outPlaylist = outPlaylist
    if "title_limit" in kargs:
        _outPlaylist = _outPlaylist.replace(
            "%(title)s", "%(title)" + kargs["title_limit"]
        )
    if "playlist_limit" in kargs:
        _outPlaylist = _outPlaylist.replace(
            "%(playlist)s", "%(playlist)" + kargs["playlist_limit"]
        )
    archive = kargs["--download-archive"]
    archive = f'--download-archive "{archive}"'
    command = f"yt-dlp {proxy} {cf} {ws} {was} {langs} {cs} {embed} {cookie} {playlist} {outPlaylistJson} {audio} {replace} {overWrite} {archive} {wirteJson} {args[0]}"
    print(command)
    subprocess.run(command, cwd=cwd)


def ydl_video_audio(cwd, *args, **kargs):
    # download all videos
    _outPlaylist = outPlaylist
    if "title_limit" in kargs:
        _outPlaylist = _outPlaylist.replace(
            "%(title)s", "%(title)" + kargs["title_limit"]
        )
    archive = kargs["--download-archive"]
    archive = f'--download-archive "{archive}"'
    command = f"yt-dlp {proxy} {cf} {ws} {was} {langs} {cs} {embed} {cookie} {video} {outVideoJson} {audio} {replace} {overWrite} {archive} {wirteJson} {args[0]}"
    print(command)
    subprocess.run(command, cwd=cwd)


command_obj = {
    "test_command": test_command,
    "ydl_playlist_audio": ydl_playlist_audio,
    "ydl_video_audio": ydl_video_audio,
}
