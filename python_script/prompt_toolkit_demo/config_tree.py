#!/usr/bin/env python3
# coding: utf-8

config_option = {
    "value": "root",
    "children": [
        {
            "value": "yt-dlp youtube",
            "children": [
                {
                    "key": "ypa",
                    "value": r"ydl_playlist_audio",
                    "command": r"ydl_playlist_audio",
                    "command_mode": "function",
                    "cwd": r"D:\my_repo\parrot_fashion\download",
                    "args": [
                        {
                            "value": "url",
                            "input": "",
                            "input_prompt": "url: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "--download-archive <file name>",
                            "input_key": "--download-archive",
                            "input_value": "",
                            "input_value_prompt": "--download-archive: ",
                            "mode": "kargs",
                            "default": True,
                        },
                    ],
                },
                {
                    "key": "yva",
                    "value": r"ydl_video_audio",
                    "command": r"ydl_video_audio",
                    "command_mode": "function",
                    "cwd": r"D:\my_repo\parrot_fashion\download",
                    "args": [
                        {
                            "value": "url",
                            "input": "",
                            "input_prompt": "url ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "--download-archive <file name>",
                            "input_key": "--download-archive",
                            "input_value": "",
                            "input_value_prompt": "--download-archive",
                            "mode": "kargs",
                            "default": True,
                        },
                    ],
                },
                {
                    "key": "d_bbc",
                    "value": r"download BBC Learning English",
                    "command": r"ydl_playlist_audio",
                    "command_mode": "function",
                    "cwd": r"D:\my_repo\parrot_fashion\download",
                    "args": [
                        {
                            "value": "url",
                            "input": "https://www.youtube.com/playlist?list=PLcetZ6gSk96-FECmH9l7Vlx5VDigvgZpt",
                            "input_prompt": "url ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "--download-archive <file name>",
                            "input_key": "--download-archive",
                            "input_value": "BBC Learning English/6 Minute English - Vocabulary & listening PLcetZ6gSk96-FECmH9l7Vlx5VDigvgZpt.txt",
                            "input_value_prompt": "--download-archive",
                            "mode": "kargs",
                            "default": True,
                        },
                    ],
                },
                {
                    "key": "d_kur",
                    "value": r"download Kurzgesagt",
                    "command": r"ydl_video_audio",
                    "command_mode": "function",
                    "cwd": r"D:\my_repo\parrot_fashion\download",
                    "args": [
                        {
                            "value": "url",
                            "input": "https://www.youtube.com/@kurzgesagt",
                            "input_prompt": "url ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "--download-archive <file name>",
                            "input_key": "--download-archive",
                            "input_value": "Kurzgesagt – In a Nutshell/_videos.txt",
                            "input_value_prompt": "--download-archive",
                            "mode": "kargs",
                            "default": True,
                        },
                    ],
                },
            ],
        },
        {
            "value": "whisper -> autosub -> anki",
            "children": [
                {
                    "key": "bbc",
                    "value": r"loop_whisper loop BBC Learning English",
                    "command": r'pdm run python loop_whisper.py loop "D:\my_repo\parrot_fashion\download\BBC Learning English"',
                    "command_mode": "command",
                    "cwd": r"D:\my_repo\parrot_fashion\crawler",
                    "args": [
                        {
                            "value": "--skip <number>",
                            "input_key": "--skip",
                            "input_value": "",
                            "input_value_prompt": "跳过文件,0为不跳过,--skip: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "--check <bool>",
                            "input_key": "--check",
                            "input_value": "1",
                            "mode": "kargs",
                            "default": False,
                        },
                    ],
                    "help": [
                        {"value": "help example1"},
                    ],
                },
                {
                    "key": "kur",
                    "value": r"loop_whisper loop Kurzgesagt",
                    "command": r'pdm run python loop_whisper.py loop "D:\my_repo\parrot_fashion\download\Kurzgesagt – In a Nutshell"',
                    "command_mode": "command",
                    "cwd": r"D:\my_repo\parrot_fashion\crawler",
                    "args": [
                        {
                            "value": "--skip <number>",
                            "input_key": "--skip",
                            "input_value": "",
                            "input_value_prompt": "--skip: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "--check <bool>",
                            "input_key": "--check",
                            "input_value": "1",
                            "mode": "kargs",
                            "default": False,
                        },
                    ],
                    "help": [
                        {"value": "help example1"},
                    ],
                },
            ],
        },
        {
            "key": "autosub",
            "value": r"tool autosub srt",
            "command": r'pdm run python D:\my_repo\parrot_fashion\crawler\autosub_tool.py ats "{}"',
            "command_mode": "command",
            "cwd": r"D:\my_repo\parrot_fashion\crawler",
            "args": [
                {
                    "value": "input srtPath",
                    "input": "",
                    "input_prompt": "input file srtPath: ",
                    "mode": "args",
                    "default": True,
                }
            ],
            "help": [
                {"value": "help example1"},
            ],
        },
        {
            "value": r"ffmpeg tool",
            "children": [
                {
                    "key": "reduce",
                    "value": r"ffmpeg reduceVideoSize",
                    "command": r'ffmpeg -i "{}" -vcodec libx265 -crf 24 "{}"',
                    "command_mode": "command",
                    "args": [
                        {
                            "value": "input file path",
                            "input": "",
                            "input_prompt": "input file: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "output file path",
                            "input": "",
                            "input_prompt": "output file: ",
                            "mode": "args",
                            "default": True,
                        },
                    ],
                },
                {
                    "value": r"test function command",
                    "command": "test_command",
                    "command_mode": "function",
                    "cwd": "D:",
                    "key": "t",
                    "args": [
                        {
                            "value": "input file path",
                            "input": "",
                            "input_prompt": "input file: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "output file path",
                            "input": "",
                            "input_prompt": "output file: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "--check <bool>",
                            "input_key": "--check",
                            "input_value": "",
                            "input_value_prompt": "check <number>",
                            "mode": "kargs",
                            "default": True,
                        },
                    ],
                },
                {
                    "value": r"test function command2",
                    "command": "ping {}",
                    "command_mode": "command",
                    "key": "p",
                    "args": [
                        {
                            "value": "input address",
                            "input": "",
                            "input_prompt": "input address: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "-n <number>",
                            "input_key": "-n",
                            "input_value": "",
                            "input_value_prompt": "-n <number>",
                            "mode": "kargs",
                            "default": True,
                        },
                    ],
                },
            ],
        },
    ],
}
