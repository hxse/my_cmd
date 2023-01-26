#!/usr/bin/env python3
# coding: utf-8

config_option = {
    "value": "root",
    "children": [
        {
            "value": "whisper -> autosub -> anki",
            "children": [
                {
                    "value": r"loop_whisper loop BBC Learning English",
                    "command": r'pdm run python loop_whisper.py loop "D:\my_repo\parrot_fashion\download\BBC Learning English"',
                    "cwd": r"D:\my_repo\parrot_fashion\crawler",
                    "args": [{"value": "--skip", "input": ""}, {"value": "--check 1"}],
                    "help": [
                        {"value": "help example1"},
                    ],
                },
                {
                    "value": r"loop_whisper loop Kurzgesagt",
                    "command": r'pdm run python loop_whisper.py loop "D:\my_repo\parrot_fashion\download\Kurzgesagt – In a Nutshell"',
                    "cwd": r"D:\my_repo\parrot_fashion\crawler",
                    "args": [{"value": "--skip", "input": ""}, {"value": "--check 1"}],
                    "help": [
                        {"value": "help example1"},
                    ],
                },
            ],
        }
    ],
}
