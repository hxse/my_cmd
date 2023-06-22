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
                        {
                            "value": "title limit size",
                            "input_key": "title_limit",
                            "input_value": ".35B",
                            "input_value_prompt": "title limit size",
                            "mode": "kargs",
                            "default": False,
                        },
                        {
                            "value": "playlist limit size",
                            "input_key": "playlist_limit",
                            "input_value": ".41B",
                            "input_value_prompt": "playlist limit size",
                            "mode": "kargs",
                            "default": False,
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
                {
                    "key": "d_bs",
                    "value": r"download Be Smart",
                    "command": r"ydl_video_audio",
                    "command_mode": "function",
                    "cwd": r"D:\my_repo\parrot_fashion\download",
                    "args": [
                        {
                            "value": "url",
                            "input": "https://www.youtube.com/@besmart",
                            "input_prompt": "url ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "--download-archive <file name>",
                            "input_key": "--download-archive",
                            "input_value": "Be Smart/_videos.txt",
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
                    "key": "lw",
                    "value": r"loop_whisper",
                    "command": r"pdm run python loop_whisper.py loop {} {} {} {}",
                    "command_mode": "command",
                    "cwd": r"D:\my_repo\parrot_fashion\crawler",
                    "args": [
                        {
                            "value": "dir path <str>",
                            "input": "",
                            "input_prompt": "input dir path: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "enable whisperx <bool>",
                            "input": "1",
                            "input_prompt": "enable whisperx <bool>: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "enable autosub <bool>",
                            "input": "1",
                            "input_prompt": "enable autosub <bool>: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "enable generator anki <bool>",
                            "input": "1",
                            "input_prompt": "enable generator anki <bool>: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "--skip <number>",
                            "input_key": "--skip",
                            "input_value": "",
                            "input_value_prompt": "跳过文件,默认为0为不跳过,--skip: ",
                            "input_value_replace": [[[""], 0], [["a"], 1], [["b"], 2]],
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
                        {
                            "value": "operate mode <bool>",
                            "input_key": "--operate-mode",
                            "input_value": "en_no_comma",
                            "input_value_prompt": "operate mode: ",
                            "mode": "kargs",
                            "default": True,
                        },
                    ],
                    "help": [
                        {"value": "help example1"},
                    ],
                },
                {
                    "key": "bbc",
                    "value": r"loop_whisper loop BBC Learning English",
                    "command": r'pdm run python loop_whisper.py loop "D:\my_repo\parrot_fashion\download\BBC Learning English" {} {} {}',
                    "command_mode": "command",
                    "cwd": r"D:\my_repo\parrot_fashion\crawler",
                    "args": [
                        {
                            "value": "enable whisperx <bool>",
                            "input": "1",
                            "input_prompt": "enable whisperx <bool>: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "enable autosub <bool>",
                            "input": "1",
                            "input_prompt": "enable autosub <bool>: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "enable generator anki <bool>",
                            "input": "1",
                            "input_prompt": "enable generator anki <bool>: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "--skip <number>",
                            "input_key": "--skip",
                            "input_value": "",
                            "input_value_prompt": "跳过文件,默认为0为不跳过,--skip: ",
                            "input_value_replace": [[[""], 0], [["a"], 1], [["b"], 2]],
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
                        {
                            "value": "operate mode <bool>",
                            "input_key": "--operate-mode",
                            "input_value": "en_no_comma",
                            "input_value_prompt": "operate mode: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "start time offset <int>",
                            "input_key": "--start-offset",
                            "input_value": -200,
                            "input_value_prompt": "start time offset: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "end time offset <int>",
                            "input_key": "--end-offset",
                            "input_value": 200,
                            "input_value_prompt": "end time offset: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "over start <bool>",
                            "input_key": "--over-start",
                            "input_value": 0,
                            "input_value_prompt": "over start<bool>: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "over end <bool>",
                            "input_key": "--over-end",
                            "input_value": 0,
                            "input_value_prompt": "over end<bool>: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "whisper_name <string>",
                            "input_key": "--whisper-name",
                            "input_value": "wc2",
                            "input_value_prompt": "whisper_name<string>(wc2 or wsx): ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "import anki apkg <bool>",
                            "input_key": "--import-anki",
                            "input_value": "0",
                            "input_value_prompt": "import anki apkg: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "anki app path <str>",
                            "input_key": "--anki-app",
                            "input_value": r"C:\Program Files\Anki\anki.exe",
                            "input_value_prompt": "anki app path: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "initial_prompt <str>",
                            "input_key": "--initial-prompt",
                            "input_value": "Please, listen to dialogue and question. the example question one: What is the color of this apple? Is it, a red, b green, c yellow? the example question two: What kind of transportation did he take?  Was it, a car, b bike, c bus?",
                            "input_value_prompt": "initial_prompt: <str>",
                            "mode": "kargs",
                            "default": True,
                        },
                    ],
                    "help": [
                        {"value": "help example1"},
                    ],
                },
                {
                    "key": "kur",
                    "value": r"loop_whisper loop Kurzgesagt",
                    "command": r'pdm run python loop_whisper.py loop "D:\my_repo\parrot_fashion\download\Kurzgesagt – In a Nutshell" {} {} {}',
                    "command_mode": "command",
                    "cwd": r"D:\my_repo\parrot_fashion\crawler",
                    "args": [
                        {
                            "value": "enable whisperx <bool>",
                            "input": "1",
                            "input_prompt": "enable whisperx <bool>: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "enable autosub <bool>",
                            "input": "1",
                            "input_prompt": "enable autosub <bool>: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "enable generator anki <bool>",
                            "input": "1",
                            "input_prompt": "enable generator anki <bool>: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "--skip <number>",
                            "input_key": "--skip",
                            "input_value": "",
                            "input_value_prompt": "--skip: ",
                            "input_value_replace": [[[""], 0], [["a"], 1], [["b"], 2]],
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
                        {
                            "value": "operate mode <bool>",
                            "input_key": "--operate-mode",
                            "input_value": "en_no_comma",
                            "input_value_prompt": "operate mode: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "start time offset <int>",
                            "input_key": "--start-offset",
                            "input_value": -200,  # -200
                            "input_value_prompt": "start time offset: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "end time offset <int>",
                            "input_key": "--end-offset",
                            "input_value": 200,  # 200
                            "input_value_prompt": "end time offset: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "over start <bool>",
                            "input_key": "--over-start",
                            "input_value": 0,
                            "input_value_prompt": "over start<bool>: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "over end <bool>",
                            "input_key": "--over-end",
                            "input_value": 0,
                            "input_value_prompt": "over end<bool>: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "whisper_name <string>",
                            "input_key": "--whisper-name",
                            "input_value": "wc2",
                            "input_value_prompt": "whisper_name<string>(wc2 or wsx): ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "import anki apkg <bool>",
                            "input_key": "--import-anki",
                            "input_value": "0",
                            "input_value_prompt": "import anki apkg: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "anki app path <str>",
                            "input_key": "--anki-app",
                            "input_value": r"C:\Program Files\Anki\anki.exe",
                            "input_value_prompt": "anki app path: ",
                            "mode": "kargs",
                            "default": True,
                        },
                    ],
                    "help": [
                        {"value": "help example1"},
                    ],
                },
                {
                    "key": "bs",
                    "value": r"loop_whisper loop Be Smart",
                    "command": r'pdm run python loop_whisper.py loop "D:\my_repo\parrot_fashion\download\Be Smart" {} {} {}',
                    "command_mode": "command",
                    "cwd": r"D:\my_repo\parrot_fashion\crawler",
                    "args": [
                        {
                            "value": "enable whisperx <bool>",
                            "input": "1",
                            "input_prompt": "enable whisperx <bool>: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "enable autosub <bool>",
                            "input": "1",
                            "input_prompt": "enable autosub <bool>: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "enable generator anki <bool>",
                            "input": "1",
                            "input_prompt": "enable generator anki <bool>: ",
                            "mode": "args",
                            "default": True,
                        },
                        {
                            "value": "--skip <number>",
                            "input_key": "--skip",
                            "input_value": "",
                            "input_value_prompt": "--skip: ",
                            "input_value_replace": [[[""], 0], [["a"], 1], [["b"], 2]],
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
                        {
                            "value": "operate mode <bool>",
                            "input_key": "--operate-mode",
                            "input_value": "en_no_comma",
                            "input_value_prompt": "operate mode: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "start time offset <int>",
                            "input_key": "--start-offset",
                            "input_value": -200,
                            "input_value_prompt": "start time offset: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "end time offset <int>",
                            "input_key": "--end-offset",
                            "input_value": 200,
                            "input_value_prompt": "end time offset: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "over start <bool>",
                            "input_key": "--over-start",
                            "input_value": 0,
                            "input_value_prompt": "over start<bool>: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "over end <bool>",
                            "input_key": "--over-end",
                            "input_value": 0,
                            "input_value_prompt": "over end<bool>: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "whisper_name <string>",
                            "input_key": "--whisper-name",
                            "input_value": "wc2",
                            "input_value_prompt": "whisper_name<string>(wc2 or wsx): ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "import anki apkg <bool>",
                            "input_key": "--import-anki",
                            "input_value": "0",
                            "input_value_prompt": "import anki apkg: ",
                            "mode": "kargs",
                            "default": True,
                        },
                        {
                            "value": "anki app path <str>",
                            "input_key": "--anki-app",
                            "input_value": r"C:\Program Files\Anki\anki.exe",
                            "input_value_prompt": "anki app path: ",
                            "mode": "kargs",
                            "default": True,
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
            "command": r"pdm run python D:\my_repo\parrot_fashion\crawler\autosub_tool.py ats {}",
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
            "key": "ga",
            "value": r"generator anki",
            "command": r"pdm run python gen_anki.py ga {} {} {}",
            "command_mode": "command",
            "cwd": r"D:\my_repo\parrot_fashion\crawler",
            "args": [
                {
                    "value": "input audio Path",
                    "input": "",
                    "input_prompt": "input audio Path: ",
                    "mode": "args",
                    "default": True,
                },
                {
                    "value": "input srtPath",
                    "input": "",
                    "input_prompt": "input file srtPath: ",
                    "mode": "args",
                    "default": True,
                },
                {
                    "value": "input srt2Path",
                    "input": "",
                    "input_prompt": "input file srt2Path: ",
                    "mode": "args",
                    "default": True,
                },
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
                    "command": r"ffmpeg -i {} -vcodec libx265 -crf 24 {}",
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
            ],
        },
        {
            "value": r"test",
            "children": [
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
                            "input_value_replace": [[[""], 0], [["a"], 1], [["b"], 2]],
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
