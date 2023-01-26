from prompt_toolkit import prompt
from prompt_toolkit.application import Application
from prompt_toolkit.key_binding import KeyBindings
from prompt_toolkit.layout.containers import Window, ScrollOffsets
from prompt_toolkit.layout.controls import FormattedTextControl
from prompt_toolkit.layout.containers import ConditionalContainer, HSplit
from prompt_toolkit.layout.layout import Layout
from prompt_toolkit.filters import Condition
from prompt_toolkit.formatted_text import (
    ANSI,
    HTML,
    FormattedText,
    AnyFormattedText,
    to_formatted_text,
)
from pypinyin import pinyin, lazy_pinyin
from get_tree import Tree
import copy

show_select = 0
history = ""
state = True
message = ""
offset = 0
splitKey = "|"
splitStr = "|"
selectArr = []
mode = 0  # 0是主页面,1是子页面(一般显示args和help的子页面)
last = {}


def is_all_chinese(strs):
    for _char in strs:
        if not "\u4e00" <= _char <= "\u9fa5":
            return False
    return True


def word_match(options):
    optionsArr = []
    for word in options:
        wordArr = []
        for letter in word:
            if is_all_chinese(letter):
                wordArr.append(lazy_pinyin(letter)[0][0])
            else:
                wordArr.append(letter)
        optionsArr.append(wordArr)
    return ["".join(i) for i in optionsArr]


def get_message():
    global message
    bg = "#22a7f2"
    bg = ""
    fg = "ansiblack"
    fg = ""
    from datetime import datetime

    nt = datetime.now()
    # print(f"now time: {nt:%F %X.%f}")
    message = message.replace("&", "&amp;")
    message = message.replace("<", "&lt;")
    message = message.replace(">", "&gt;")

    html = HTML(f'{nt:%F %X} <style fg="{fg}" bg="{bg}">{message}</style>')
    return to_formatted_text(html)


def get_text():
    show_opt_offset = [
        show_opt[k + offset]
        for k, v in enumerate(show_opt)
        if k + offset <= len(show_opt) - 1
    ]
    indentation = 4
    get_text = (
        lambda x, s: f"{s}{' '*(x['level']*indentation-1) }{'└'}{'─'*(3)} {x['value']}\n"
    )
    return [
        ("class:reverse", get_text(option[v], ">"))
        if k == show_select
        else ("", get_text(option[v], " "))
        for k, v in enumerate(show_opt_offset)
    ]


l = FormattedTextControl(get_text, show_cursor=False, focusable=True)
w = Window(
    # height=Dimension.exact(h),
    content=l,
    scroll_offsets=ScrollOffsets(top=5, bottom=5, left=5),
)

layout = Layout(
    HSplit(
        [
            ConditionalContainer(
                content=Window(
                    height=1,
                    content=FormattedTextControl(get_message, show_cursor=False),
                ),
                filter=Condition(lambda: state),
            ),
            ConditionalContainer(content=w, filter=Condition(lambda: state)),
        ]
    )
)

kb = KeyBindings()


@kb.add("a", eager=True)
@kb.add("b", eager=True)
@kb.add("c", eager=True)
@kb.add("d", eager=True)
@kb.add("e", eager=True)
@kb.add("f", eager=True)
@kb.add("g", eager=True)
@kb.add("h", eager=True)
@kb.add("i", eager=True)
@kb.add("j", eager=True)
@kb.add("k", eager=True)
@kb.add("l", eager=True)
@kb.add("m", eager=True)
@kb.add("n", eager=True)
@kb.add("o", eager=True)
@kb.add("p", eager=True)
@kb.add("q", eager=True)
@kb.add("r", eager=True)
@kb.add("s", eager=True)
@kb.add("t", eager=True)
@kb.add("u", eager=True)
@kb.add("v", eager=True)
@kb.add("w", eager=True)
@kb.add("x", eager=True)
@kb.add("y", eager=True)
@kb.add("z", eager=True)
@kb.add("0", eager=True)
@kb.add("1", eager=True)
@kb.add("2", eager=True)
@kb.add("3", eager=True)
@kb.add("4", eager=True)
@kb.add("5", eager=True)
@kb.add("6", eager=True)
@kb.add("7", eager=True)
@kb.add("8", eager=True)
@kb.add("9", eager=True)
@kb.add(".", eager=True)
@kb.add(",", eager=True)
@kb.add("-", eager=True)
@kb.add("+", eager=True)
@kb.add("*", eager=True)
@kb.add("/", eager=True)
@kb.add("\\", eager=True)
@kb.add("=", eager=True)
@kb.add("&", eager=True)
@kb.add("|", eager=True)
@kb.add("?", eager=True)
@kb.add("!", eager=True)
@kb.add("%", eager=True)
@kb.add('"', eager=True)
@kb.add("'", eager=True)
@kb.add("`", eager=True)
@kb.add("[", eager=True)
@kb.add("]", eager=True)
@kb.add("<", eager=True)
@kb.add(">", eager=True)
@kb.add("(", eager=True)
@kb.add(")", eager=True)
@kb.add("{", eager=True)
@kb.add("}", eager=True)
@kb.add("@", eager=True)
@kb.add("_", eager=True)
@kb.add("#", eager=True)
@kb.add("~", eager=True)
@kb.add("^", eager=True)
@kb.add("$", eager=True)
@kb.add(splitKey, eager=True)
def search(event):
    global history
    history = (
        history + splitStr
        if event.key_sequence[0].key == splitKey
        else history + event.key_sequence[0].key
    )
    update()


def update():
    global history, option, show_opt, show_select, message, offset
    result = [[k, v] for k, v in enumerate(word_match([i["value"] for i in option]))]
    if splitStr in history:
        for h in history.split(splitStr):
            result = [[k, v] for k, v in result if h in v.lower()]
        show_opt = [k for k, v in result]
    else:
        show_opt = [k for k, v in result if history in v.lower()]
    show_select = 0
    offset = 0
    message = (
        f"{history} {selectArr} {show_opt[show_select] if len(show_opt)>0 else 'None'}"
    )


def multiple_select(isOnlyAdd=False):
    global history, option, show_opt, show_select, message, offset
    if len(show_opt) > 0:
        i = show_opt[show_select + offset]
        if i in selectArr:
            if not isOnlyAdd:
                selectArr.remove(i)
        else:
            selectArr.append(i)
    message = f"{history} {selectArr}"


@kb.add("space", eager=True)
def space(event):
    multiple_select()


@kb.add("s-tab", eager=True)
@kb.add("up", eager=True)
def up(event):
    global history, option, show_opt, show_select, message, offset
    if len(show_opt) <= w.render_info.window_height:
        # 列表小于等于页面高度
        offset = 0
        show_select = len(show_opt) - 1 if show_select == 0 else show_select - 1
        message = f"0 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"
        # show_select = len(show_opt) - 1
        return
    if show_select + offset == 0:
        # 无需偏移,碰到顶部,回到底部
        offset = len(show_opt) - 1 - (w.render_info.window_height - 1)
        show_select = w.render_info.window_height - 1
        message = f"1 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"
        return
    if show_select - 1 < 0:
        # 向上偏移
        offset = offset - 1  # -1 if offset >= 0 else offset - 1
        message = f"2 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"
        return
    show_select = show_select - 1
    if show_select < 0:
        # 无需偏移
        show_select = len(show_opt) - 1
    message = f"3 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"


@kb.add("tab", eager=True)
@kb.add("down", eager=True)
def down(event):
    # Control-I 和tab 是一个键
    global history, option, show_opt, show_select, message, offset
    if len(show_opt) <= w.render_info.window_height:
        # 列表小于等于页面高度
        offset = 0
        show_select = 0 if show_select == len(show_opt) - 1 else show_select + 1
        message = f"0 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"
        return
    if show_select + offset == len(show_opt) - 1:
        # 无需偏移,碰到底部,回到首选
        offset = 0
        show_select = 0
        message = f"1 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"
        return
    if show_select + 1 >= w.render_info.window_height:
        # 向下偏移
        offset += 1
        message = f"2 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"
        return
    show_select = show_select + 1
    if show_select >= len(show_opt):
        # 无需偏移
        show_select = 0
    message = f"3 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"


@kb.add("pageup", eager=True)
def pageup(event):
    global history, option, show_opt, show_select, message, offset
    lines = w.render_info.window_height
    if len(show_opt) <= w.render_info.window_height:
        # 列表小于等于页面高度
        message = f"0 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"
        return
    if offset - lines < 0:
        offset = (
            len(show_opt) - (len(show_opt) % lines)
            if (len(show_opt) % lines) > 0
            else len(show_opt) - (len(show_opt) % lines) - lines
        )
        show_select = 0
        message = f"1 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"
        return
    offset = offset - lines
    show_select = 0
    message = f"2 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"
    return


@kb.add("pagedown", eager=True)
def pagedown(event):
    global history, option, show_opt, show_select, message, offset
    lines = w.render_info.window_height
    if len(show_opt) <= w.render_info.window_height:
        # 列表小于等于页面高度
        message = f"0 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"
        return
    if offset + lines >= len(show_opt):
        offset = 0
        show_select = 0
        message = f"1 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"
        return
    offset += lines
    show_select = 0
    message = f"2 {history} {selectArr} {show_select} {len(option)} {show_opt[show_select] if len(show_opt)>0 else 'None'} {offset} {w.render_info.window_height}"
    return


@kb.add("backspace", eager=True)
def backspace(event):
    # ctrl-h 和 backspace是同一个键 https://github.com/prompt-toolkit/python-prompt-toolkit/issues/257
    global history
    history = history[:-1]
    update()


@kb.add("escape", eager=True)
def clean_history(event):
    global history, show_opt, option, show_select, message, offset, selectArr
    history = ""
    show_opt = [k for k, v in enumerate(option)]
    show_select = 0
    offset = 0
    selectArr = []
    message = (
        f"{history} {selectArr} {show_opt[show_select] if len(show_opt)>0 else 'None'}"
    )


@kb.add("enter", eager=True)
def set_answer(event):
    global option, show_opt, show_select, offset
    if len(show_opt) > 0:
        multiple_select(isOnlyAdd=True)
        result = [option[i] for i in selectArr]
        event.app.exit(result=result)


def update_last():
    global option, show_opt, show_select, offset, mode, last, selectArr
    last["option"] = copy.deepcopy(option)
    last["show_opt"] = copy.deepcopy(show_opt)
    last["offset"] = copy.deepcopy(offset)
    last["show_select"] = copy.deepcopy(show_select)
    last["selectArr"] = copy.deepcopy(selectArr)


def restore_last():
    global option, show_opt, show_select, offset, mode, last, selectArr
    option = last["option"]
    show_opt = last["show_opt"]
    offset = last["offset"]
    show_select = last["show_select"]
    selectArr = last["selectArr"]


def get_sub_page(field):
    global option, show_opt, show_select, offset, mode, last, selectArr, message
    if mode == 0:
        if len(show_opt) > 0:
            result = option[show_opt[show_select + offset]]
            if not (
                field not in result or result[field] == None or len(result[field]) == 0
            ):
                update_last()
                option = [
                    {"level": 1, **i}
                    for i in tree.get_from_index(result["index"])[field]
                ]
                show_opt = [k for k, v in enumerate(option)]
                offset = 0
                show_select = 0
                selectArr = []
                mode = 1
                message = f"{history} {selectArr} {show_opt[show_select] if len(show_opt)>0 else 'None'}"

    elif mode == 1:
        restore_last()
        mode = 0
        message = f"{history} {selectArr} {show_opt[show_select] if len(show_opt)>0 else 'None'}"


@kb.add("c-a", eager=True)
def get_args(event):
    get_sub_page("args")


@kb.add("c-s", eager=True)
def get_help(event):
    get_sub_page("help")


@kb.add("c-d", eager=True)
def d(event):
    # page down
    # print(w.render_info.window_height)
    # print(w.__dir__())
    # print(l.__dir__())
    # print(l.focusable())
    # print(w.scroll_offsets)
    w.render_info.vertical_scroll = 5
    l.move_cursor_down()
    global app
    # app._redraw()


@kb.add("c-q", eager=True)
@kb.add("c-c", eager=True)
def c(event):
    raise KeyboardInterrupt()


def run_app_tree(_tree):
    global option, show_opt, tree
    tree = _tree

    option = [i for i in tree.generator_list()]
    show_opt = [k for k, v in enumerate(option)]

    app = Application(
        layout=layout,
        full_screen=True,
        key_bindings=kb,
        # refresh_interval=1,
    )
    result = app.run()
    if "isSub" in result and result["isSub"] == True:
        if "input" in result:
            result["input"] = prompt(f"{result['value']}: ")
    return result


if __name__ == "__main__":
    from config_tree_test import config_option

    tree = Tree(config_option)
    result = run_app_tree(tree)
    print(result)
