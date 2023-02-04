from tool_list import run_app_list
from tool_tree import run_app_tree
from get_tree import Tree
import os, subprocess
from config_tree import config_option


def insert_args(args_obj):
    if args_obj["mode"] == "args":
        assert "input" in args_obj, "配置文件,args对象需要有input项才行"
        if args_obj["input"] == "":
            args_obj["input"] = input(f'{args_obj["input_prompt"]}')
        # args.append(args_obj["input"])
        return ["args", args_obj["input"]]
        # command = command.replace("{}", args_obj["input"], 1)
    if args_obj["mode"] == "kargs":
        assert "input_key" in args_obj, "配置文件,kargs对象需要有input_key项才行"
        assert "input_value" in args_obj, "配置文件,kargs对象需要有input_value项才行"
        if args_obj["input_key"] == "":
            args_obj["input_key"] = input(f'{args_obj["input_key_prompt"]}')
        if args_obj["input_value"] == "":
            args_obj["input_value"] = input(f'{args_obj["input_value_prompt"]}')
        # kargs[args_obj["input_key"]] = args_obj["input_value"]
        return ["kargs", {args_obj["input_key"]: args_obj["input_value"]}]

    # command = command.replace("\{\}", "{}")  # 处理转义花括号


def merge_args(args_list, enableDefault=False):
    args = []
    kargs = {}
    for i in args_list:  # loop [args]
        if enableDefault == True and i["default"] != True:
            continue
        [flag, result] = insert_args(i)
        if flag == "args":
            args = [*args, result]
        if flag == "kargs":
            kargs = {**kargs, **result}
    return args, kargs


def replace_args(command, args, kargs):
    for i in args:
        command = command.replace("{}", i, 1)
    for k, v in kargs.items():
        command = f"{command} {k} {v}"
    return command.replace("\{\}", "{}")  # 处理转义花括号


def run_command(command, args=[], kargs={}, cwd=None):
    if type(command) == str:
        command = replace_args(command, args, kargs)
        if cwd:
            print(cwd)
        print(command)
        subprocess.run(command, cwd=cwd)
    else:
        command(*args, **kargs)


def main():
    tree = Tree(config_option)
    result = run_app_tree(tree)
    if len(result) > 0:
        i0 = result[0]
        if not ("isSub" not in i0 or i0["isSub"] == False):
            parent_index = i0["parent"]
            parent = tree.get_from_index(parent_index)
            command = parent["command"]
            cwd = parent["cwd"] if "cwd" in parent else None
            [args, kargs] = merge_args(result)
            run_command(command, args, kargs, cwd=cwd)
        else:
            for i in result:  # loop [command]
                command = i["command"]
                cwd = i["cwd"] if "cwd" in i else None
                if "args" not in i or len(i["args"]) == 0:
                    run_command(command, cwd=cwd)
                    continue
                [args, kargs] = merge_args(i["args"], enableDefault=True)
                run_command(command, args, kargs, cwd=cwd)


if __name__ == "__main__":
    main()
