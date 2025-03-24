import sys, os

sys.path.append(
    os.path.dirname(os.path.abspath(__file__)) + "/.."
)  # import tool from parent dir
from tool import convert2d, convert2dIndex, z_fill
from simple_fire import simple_fire
import subprocess
from pathlib import Path
import shutil
import hashlib


def export_codes_to_file(*code_files, output_file="exported_codes.txt"):
    """
    将多个代码文件的绝对路径和内容导出到一个文件中。

    参数：
    - code_files: 包含代码文件路径的列表
    - output_file: 输出的文件名，默认为 exported_codes.txt
    """
    try:
        with open(output_file, "w", encoding="utf-8") as outfile:
            file_arr = []
            for code_file in code_files:
                abs_path = os.path.abspath(code_file)
                # 检查文件是否存在
                if not os.path.exists(code_file):
                    print(f"错误：文件 {code_file} 不存在，跳过此文件。")
                    continue
                file_arr.append(abs_path)

            for i in file_arr:
                outfile.write(f"{i}\n")

            outfile.write(
                f"\n下面是代码内容, 请检查是否读取到了全部 {len(file_arr)} 个文件内容\n\n"
            )

            for code_file in code_files:
                # 获取文件的绝对路径
                abs_path = os.path.abspath(code_file)

                # 检查文件是否存在
                if not os.path.exists(code_file):
                    print(f"错误：文件 {code_file} 不存在，跳过此文件。")
                    continue

                # 读取文件内容
                try:
                    with open(code_file, "r", encoding="utf-8") as infile:
                        code_content = infile.read()
                except Exception as e:
                    print(
                        f"错误：无法读取文件 {code_file}，错误信息：{e}，跳过此文件。"
                    )
                    continue

                # 写入绝对路径
                outfile.write(f"{abs_path}\n")
                # 写入代码内容，使用 ``` 分隔
                outfile.write("```\n")
                outfile.write(f"{code_content}\n")
                outfile.write("```\n\n")

        print(f"成功导出到 {output_file}")

    except Exception as e:
        print(f"错误：无法写入文件 {output_file}，错误信息：{e}")


if __name__ == "__main__":
    simple_fire(
        {
            "export_codes_to_file": export_codes_to_file,
        }
    )
