from tool_list import run_app_list
from tool_tree import run_app_tree
from get_tree import Tree
import os, subprocess

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

# result = run_app_list()
# print(result)
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
            if i0["mode"] == "args":
                for i in result:
                    if "input" in i:
                        i["input"] = input(f'{i["value"]}: ')
                        command = f"{command} {i['value']} {i['input']}"
                    else:
                        command = f"{command} {i['value']}"
                print(parent["cwd"])
                print(command)
                # stdout, stderr = run_process(command, cwd=parent["cwd"], realMode=True)
                # print(stdout)
                # print(stderr)
                subprocess.run(command, cwd=parent["cwd"])

        else:
            for i in result:
                command = i["command"]
                print(i["cwd"])
                print(command)
                # stdout, stderr = run_process(command, cwd=i["cwd"], realMode=True)
                # print(stdout)
                # print(stderr)
                subprocess.run(command, cwd=i["cwd"])


if __name__ == "__main__":
    main()
