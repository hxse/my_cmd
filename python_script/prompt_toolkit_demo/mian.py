from tool_list import run_app_list
from tool_tree import run_app_tree
from get_tree import Tree
import os, subprocess
import fire

from config_tree import config_option
from config_command import command_obj


def replace_value(
    args_obj,
    key_name,
    key_name_replace,
):
    if key_name_replace in args_obj:
        for i in args_obj[key_name_replace]:
            [replace_arr, target] = i
            for i in replace_arr:
                if i == args_obj[key_name].strip():
                    return target
    return args_obj[key_name]


def insert_args(args_obj, enableDefault):
    if args_obj["mode"] == "args":
        assert "input" in args_obj, "配置文件,args对象需要有input项才行"
        if args_obj["input"] == "" or enableDefault == False:
            args_obj["input"] = input(f'{args_obj["input_prompt"]}')
            args_obj["input"] = replace_value(args_obj, "input", "input_replace")
        return ["args", [args_obj["input"]]]
    if args_obj["mode"] == "kargs":
        assert "input_key" in args_obj, "配置文件,kargs对象需要有input_key项才行"
        assert "input_value" in args_obj, "配置文件,kargs对象需要有input_value项才行"
        if args_obj["input_key"] == "":
            args_obj["input_key"] = input(f'{args_obj["input_key_prompt"]}')
            args_obj["input_key"] = replace_value(
                args_obj, "input_key", "input_key_replace"
            )
        if args_obj["input_value"] == "" or enableDefault == False:
            args_obj["input_value"] = input(f'{args_obj["input_value_prompt"]}')
            args_obj["input_value"] = replace_value(
                args_obj, "input_value", "input_value_replace"
            )
        return ["kargs", {args_obj["input_key"]: args_obj["input_value"]}]


def merge_args(args_list, enableDefault=False):
    args = []
    kargs = {}
    for i in args_list:  # loop [args]
        if enableDefault == True and i["default"] != True:
            continue
        [flag, result] = insert_args(i, enableDefault=enableDefault)
        if flag == "args":
            args = [*args, *result]
        if flag == "kargs":
            kargs = {**kargs, **result}
    return args, kargs


def replace_args(command, args, kargs):
    for i in args:
        if "{}" in command:
            command = command.replace("{}", f'"{str(i)}"', 1)
        else:
            command = f'{command} "{str(i)}"'
    for k, v in kargs.items():
        command = f'{command} {k if k.startswith("-") else "--" + k} "{v}"'
    return command.replace("{}", "").replace("\{\}", "{}")  # 清理花括号和处理转义花括号


def sort_args(args_list, args, kargs):
    return
    new_args = []
    new_kargs = []
    for i in args_list:
        if i["mode"] == "args":
            new_args.append(i)
        elif i["mode"] == "kargs":
            new_kargs.append(i)
    new_kargs.sort(key=lambda x: x["input_key"].index)
    # kargs保持顺序本来就不合理啊,不弄了


def add_input_from_args(result, args, kargs):
    # 把命令行参数添加到配置文件对象的input默认值里
    for i in result:
        if "args" not in i:
            continue
        n = 0
        n_k = []
        for a in i["args"]:
            if a["mode"] == "args":
                if n <= len(args) - 1:
                    a["input"] = args[n]
                    a["default"] = True
                n += 1
            if a["mode"] == "kargs":
                k = a["input_key"].lstrip("-").replace("-", "_")

                if k in kargs:
                    a["input_value"] = kargs[k]
                    a["default"] = True
                    n_k.append(k)

        for a in args[n:]:
            i["args"].append({"input": a, "default": True, "mode": "args"})
        for k in kargs.keys():
            if k not in n_k:
                i["args"].append(
                    {
                        "input_key": k,
                        "input_value": kargs[k],
                        "default": True,
                        "mode": "kargs",
                    }
                )
        sort_args(i["args"], args, kargs)
    return result


def run_command(command, command_mode, args=[], kargs={}, cwd=None):
    if command_mode == "command":
        command = replace_args(command, args, kargs)
        if cwd:
            print(cwd)
        print(command)
        subprocess.run(command, cwd=cwd)
    if command_mode == "function":
        command_obj[command](cwd, *args, **kargs)


def main(key=None, *args, **kargs):
    tree = Tree(config_option)
    if key == None:
        result = run_app_tree(tree)
        args = []
        kargs = {}
    else:
        result = []
        for i in tree.generator_list():
            if "key" in i and i["key"] == key:
                result.append(i)
    if len(result) <= 0:
        print("not select command")
    else:
        i0 = result[0]
        if not ("isSub" not in i0 or i0["isSub"] == False):
            parent_index = i0["parent"]
            parent = tree.get_from_index(parent_index)
            command = parent["command"]
            command_mode = parent["command_mode"]
            cwd = parent["cwd"] if "cwd" in parent else None
            result = add_input_from_args(result, args, kargs)
            [args, kargs] = merge_args(result, enableDefault=False)
            run_command(command, command_mode, args, kargs, cwd=cwd)
        else:
            for i in result:  # loop [command]
                command = i["command"]
                command_mode = i["command_mode"]
                cwd = i["cwd"] if "cwd" in i else None
                if "args" not in i or len(i["args"]) == 0:
                    run_command(command, command_mode, cwd=cwd)
                    continue
                result = add_input_from_args(result, args, kargs)
                [args, kargs] = merge_args(i["args"], enableDefault=True)
                run_command(command, command_mode, args, kargs, cwd=cwd)


if __name__ == "__main__":
    fire.Fire(main)
