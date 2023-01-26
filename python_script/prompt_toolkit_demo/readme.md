# 命令行提示工具
  * tree结构配置文件,支持设置sub field,就是按快捷键后,可以额外提示一次
  * list结构配置文件,不支持设置sub,直接返回结果
  * 支持复选
  * ctrl+a打开子菜单,选择args,ctrl+h打开子菜单,选择help,需要在配置文件定义好`{args:[]}`和`{help:[]}`字段,如果需要新增字段,需要在Tree里面传递, sub_field参数
  * list配置文件,只需要一串list字符串就好了
  * tree配置文件示例,参考config_tree.py
```
config_option = {
    "value": "root 0",
    "children": [
        {
            "value": "apple is 1 apple 1",
            "args": [{"value": "--skip", "input": ""}, {"value": "--check"}],
            "help": [
                {"value": "help example1"},
                {"value": "help example2"},
            ],
            "children": [
                {
                    "value": "apple is 1.1 banana 2",
                },
                {
                    "value": "apple is 1.2 color 3",
                    "children": [
                        {
                            "value": "2333333 4",
                        }
                    ],
                },
            ],
        },
        {
            "value": "apple is 2 color3 5",
            "children": [
                {
                    "value": "apple is 2.1 6",
                },
            ],
        },
    ],
}
```
