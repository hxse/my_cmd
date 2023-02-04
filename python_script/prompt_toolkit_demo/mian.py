from tool_list import run_app_list
from tool_tree import run_app_tree
from get_tree import Tree
import os, subprocess
from config_tree import config_option


def insert_args(
    command,
    args_obj,
):
    if args_obj["mode"] == "args":
        assert "input" in args_obj, "配置文件,args对象需要有input项才行"
        if args_obj["input"] == "":
            args_obj["input"] = input(f'{args_obj["input_prompt"]}')
        command = command.replace("{}", args_obj["input"], 1)
    if args_obj["mode"] == "kargs":
        assert "input_key" in args_obj, "配置文件,kargs对象需要有input_key项才行"
        assert "input_value" in args_obj, "配置文件,kargs对象需要有input_value项才行"
        if args_obj["input_key"] == "":
            args_obj["input_key"] = input(f'{args_obj["input_key_prompt"]}')
        if args_obj["input_value"] == "":
            args_obj["input_value"] = input(f'{args_obj["input_value_prompt"]}')
        command = f"{command} {args_obj['input_key']} {args_obj['input_value']}"
    command = command.replace("\{\}", "{}")  # 处理转义花括号
    return command


def main():
    tree = Tree(config_option)
    result = run_app_tree(tree)
    print(result)
    if len(result) > 0:
        i0 = result[0]
        if not ("isSub" not in i0 or i0["isSub"] == False):
            parent_index = i0["parent"]
            parent = tree.get_from_index(parent_index)
            command = parent["command"]
            cwd = parent["cwd"] if "cwd" in parent else None
            for i in result:  # loop [args]
                command = insert_args(command, i)
            print(cwd)
            print(command)
            subprocess.run(command, cwd=cwd)
        else:
            for i in result:  # loop [command]
                command = i["command"]
                cwd = i["cwd"] if "cwd" in i else None
                if "args" in i:
                    for i in i["args"]:
                        if i["default"]:
                            command = insert_args(command, i)
                print(cwd)
                print(command)
                subprocess.run(command, cwd=cwd)


if __name__ == "__main__":
    main()
