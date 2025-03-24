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


def convert_to_2d(input_list, step, pad_none=False):
    """
    Converts a 1D list to a 2D list with a specified step.

    Args:
        input_list: The 1D list to convert.
        step: The number of elements in each sublist (row).
        pad_none: If True, pads incomplete rows with None. If False, includes incomplete rows as-is.

    Returns:
        A 2D list.
    """
    if not isinstance(step, int) or step <= 0:
        raise ValueError("Step must be a positive integer")

    result = []
    for i in range(0, len(input_list), step):
        sublist = input_list[i : i + step]
        if pad_none and len(sublist) < step:
            sublist.extend([None] * (step - len(sublist)))
        result.append(sublist)
    return result


def export_codes_to_file(*code_files, output_file="exported_codes.txt", step=10):
    """
    将多个代码文件的绝对路径和内容导出到一个文件中。

    参数：
    - code_files: 包含代码文件路径的列表
    - output_file: 输出的文件名，默认为 exported_codes.txt
    """
    try:
        l_list = convert_to_2d(code_files, step=step)
        l_list_length = len([i for i in l_list for i in i])
        print(l_list)
        print(l_list_length)
        for k_l, v_l in enumerate(l_list):
            new_output_file = output_file.replace(".", f"_{k_l}.")
            with open(new_output_file, "w", encoding="utf-8") as outfile:
                outfile.write(
                    f"我可能会把文件拆分成多份上传, 请仔细检查是否读取到了全部 {l_list_length} 个文件内容, 以及是否存在重复遗漏疏忽\n"
                )

                outfile.write(
                    f"当前合集序号 {k_l} 当前合集内文档 {len(v_l)} 全部文档 {l_list_length}\n"
                )

                outfile.write("当前合集内文档目录如下\n")
                for file_path in v_l:
                    assert Path(file_path).is_file(), f"{file_path} 文件不存在"
                    outfile.write(f"{file_path}\n")

                outfile.write(
                    """
                    代码内容格式如下:
                    开头标注文件路径名
                    ```
                    代码内容
                    // 末尾在代码中再次注释文件路径名
                    ```
                    """
                )

                outfile.write("\n下面是代码内容如下\n\n")

                for file_path in v_l:
                    with open(file_path, "r", encoding="utf-8") as infile:
                        code_content = infile.read()
                        outfile.write(f"{file_path}\n")
                        outfile.write("```\n")
                        outfile.write(f"{code_content}\n")
                        outfile.write("```\n\n\n")

            print(f"成功导出到 {new_output_file}")

    except Exception as e:
        print(f"错误：无法写入文件 {new_output_file}，错误信息：{e}")


def test_convert_to_2d():
    # 测试 pad_none=False
    assert convert_to_2d([1, 2, 3, 4, 5], 2, False) == [[1, 2], [3, 4], [5]]
    assert convert_to_2d([1, 2, 3, 4], 2, False) == [[1, 2], [3, 4]]
    assert convert_to_2d([], 2, False) == []

    # 测试 pad_none=True
    assert convert_to_2d([1, 2, 3, 4, 5], 2, True) == [[1, 2], [3, 4], [5, None]]
    assert convert_to_2d([1, 2, 3, 4], 2, True) == [[1, 2], [3, 4]]
    assert convert_to_2d([], 2, True) == []

    # 测试边缘情况
    try:
        convert_to_2d([1, 2, 3], 0)
        assert False, "Should raise ValueError"
    except ValueError:
        pass

    print("All tests passed!")


if __name__ == "__main__":
    # test_convert_to_2d()
    simple_fire(
        {
            "export_codes_to_file": export_codes_to_file,
        }
    )
