# 命令行提示工具
  * tree结构配置文件,支持设置sub field,就是按快捷键后,可以额外提示一次
  * list结构配置文件,不支持设置sub,直接返回结果
  * 支持复选
  * ctrl+a打开子菜单,选择args,ctrl+h打开子菜单,选择help,需要在配置文件定义好`{args:[]}`和`{help:[]}`字段,如果需要新增字段,需要在Tree里面传递, sub_field参数
  * list配置文件,只需要一串list字符串就好了
  * tree配置文件示例,参考config_tree.py
  * 配置文件中的args对象中
    * 如果default为true,那么回车就可以执行参数,不需要tab选择,
    * mode,表示该参数是args还是kargs,如果是args,就需要input_value字段,如果是kargs,就需要input_key,input_value字段
    * command中的{},会被按顺序逐个替换成args,\{\}会被转义成{}
  * 在powershell中运行
```powershell
function g {
	# python terminal gui
	cd D:\my_repo\my_cmd\python_script;
	pdm run python .\prompt_toolkit_demo\mian.py
}
```
  * config_tree.py配置文件参考
```python
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
                    "value": r"loop_whisper loop Kurzgesagt",
                    "command": r'pdm run python loop_whisper.py loop "D:\my_repo\parrot_fashion\download\Kurzgesagt – In a Nutshell"',
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
            "value": r"tool autosub srt",
            "command": r'pdm run python D:\my_repo\parrot_fashion\crawler\autosub_tool.py ats "{}"',
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
                    "value": r"ffmpeg reduceVideoSize",
                    "command": r'ffmpeg -i "{}" -vcodec libx265 -crf 24 "{}"',
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
    ],
}
```
