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
    * command_mode:
        * 如果值是function,那么会在config_command.py中寻找和command同名的函数执行,cwd会被自动添加到函数传参时的kargs里面
        * 如果值是command,那么会在subprocess里面直接执行命令
    * 可以直接从命令行调用,不需要经过gui,如
        *
```powershell
function gt{
	g ypa https://www.youtube.com/playlist?list=PLnzvH6pAJKSp3NDFn_2OqsGVFpQREer3J --download-archive "archive.txt"
}
```
# 在powershell中运行
```powershell
function g {
	# python terminal gui
	cd D:\my_repo\my_cmd\python_script;
	pdm run python .\prompt_toolkit_demo\mian.py $args
}
```
# config_tree.py配置文件参考
```python
config_option = {
    "value": "root",
    "children": [
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
            "value": r"test",
            "children": [
                {
                    "value": r"test function command",
                    "command": "test_command",
                    "command_mode": "function",
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
```
# config_command.py配置文件参考
```python
#!/usr/bin/env python3
# coding: utf-8
def test_command(*args, **kargs):
    print(args, kargs)


command_obj = {"test_command": test_command}
```
