from typing import List, Optional, Tuple, Union
from prompt_toolkit.application import Application, get_app
from prompt_toolkit.filters import IsDone
from prompt_toolkit.formatted_text import AnyFormattedText
from prompt_toolkit.key_binding import KeyBindings
from prompt_toolkit.layout.containers import Window
from prompt_toolkit.layout.controls import FormattedTextControl
from prompt_toolkit.layout.layout import Layout
from prompt_toolkit.layout.dimension import Dimension
from prompt_toolkit.layout.containers import ConditionalContainer, HSplit
from prompt_toolkit.mouse_events import MouseEventType
from prompt_toolkit.styles import Style
from pypinyin import pinyin, lazy_pinyin


OptionValue = Optional[AnyFormattedText]
Option = Union[
    AnyFormattedText,  # name value is same
    Tuple[AnyFormattedText, OptionValue],  # (name, value)
]
IndexedOption = Tuple[int, AnyFormattedText, OptionValue]  # index  # name


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


history = ""


class SelectionControl(FormattedTextControl):
    def __init__(self, options: List[Option], **kwargs) -> None:
        self.options = self._index_options(options)
        self.answered = False
        self.selected_option_index = 0
        super().__init__(**kwargs)

    @property
    def selected_option(self) -> IndexedOption:
        return self.options[self.selected_option_index]

    @property
    def options_count(self) -> int:
        return len(self.options)

    def _index_options(self, options) -> List[IndexedOption]:
        """
        Convert Option to IndexedOption
        """
        indexed_options = []
        for idx, opt in enumerate(options):
            if isinstance(opt, str):
                indexed_options.append((idx, opt, opt))
            if isinstance(opt, tuple):
                if len(opt) != 2:
                    raise ValueError(f"invalid tuple option: {opt}.")
                indexed_options.append((idx, *opt))

        return indexed_options

    def _select_option(self, index):
        def handler(mouse_event):
            if mouse_event.event_type != MouseEventType.MOUSE_DOWN:
                raise NotImplemented

            # bind option with this index to mouse event
            self.selected_option_index = index
            self.answered = True
            get_app().exit(result=self.selected_option)

        return handler

    def format_option(
        self,
        option: IndexedOption,
        *,
        selected_style_class: str = "",
        selected_prefix_char: str = ">",
        indent: int = 1,
    ):
        option_prefix: AnyFormattedText = " " * indent
        idx, name, value = option
        if self.selected_option_index == idx:
            option_prefix = selected_prefix_char + option_prefix
            return (
                selected_style_class,
                f"{option_prefix}{name}\n",
                self._select_option(idx),
            )

        option_prefix += " "
        return "", f"{option_prefix}{name}\n", self._select_option(idx)


class SelectionPrompt:
    def __init__(
        self, message: AnyFormattedText = "", *, options: List[Option] = None
    ) -> None:
        self.message = message
        self.options = options

        self.control = None
        self.layout = None
        self.key_bindings = None
        self.app = None

    def _create_layout(self) -> Layout:
        """
        Create `Layout` for this prompt.
        """

        def get_option_text():
            return [
                self.control.format_option(opt, selected_style_class="class:reverse")
                for opt in self.control.options
            ]

        layout = HSplit(
            [
                Window(
                    height=Dimension.exact(1),
                    content=FormattedTextControl(
                        lambda: self.message + "\n", show_cursor=False
                    ),
                ),
                Window(
                    height=Dimension.exact(self.control.options_count),
                    content=FormattedTextControl(get_option_text),
                ),
                ConditionalContainer(Window(self.control), filter=~IsDone()),
            ]
        )
        return Layout(layout)

    def _create_key_bindings(self) -> KeyBindings:
        """
        Create `KeyBindings` for this prompt
        """
        control = self.control
        kb = KeyBindings()

        @kb.add("c-q", eager=True)
        @kb.add("c-c", eager=True)
        def _(event):
            raise KeyboardInterrupt()

        @kb.add("down", eager=True)
        def move_cursor_down(event):
            control.selected_option_index = (
                control.selected_option_index + 1
            ) % control.options_count
            self.message = f"{history} {control.selected_option}"

            # print(
            #     control.selected_option,
            #     history,
            #     control.selected_option_index,
            #     self.options_match,
            # )

        @kb.add("up", eager=True)
        def move_cursor_up(event):
            control.selected_option_index = (
                control.selected_option_index - 1
            ) % control.options_count
            self.message = f"{history} {control.selected_option}"

            # print(
            #     control.selected_option,
            #     history,
            #     control.selected_option_index,
            #     self.options_match,
            # )

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
        def move_cursor_up3(event):
            # print(event.key_sequence[0].key)
            global history
            history += event.key_sequence[0].key
            indexArr = [i for i, v in enumerate(self.options_match) if history in v]
            control.selected_option_index = (
                indexArr[0] if indexArr else control.selected_option_index
            )
            self.message = f"{history} {control.selected_option}"

            # control.selected_option_index = (
            #     control.selected_option_index + 1
            # ) % control.options_count

        # @kb.add("b", eager=True)
        # def move_cursor_up3(event):
        #     global history
        #     history += "b"
        #     indexArr = [i for i, v in enumerate(self.options_match) if history in v]
        #     control.selected_option_index = (
        #         indexArr[0] if indexArr else control.selected_option_index
        #     )

        @kb.add("escape", eager=True)
        def move_cursor_up3(event):
            # control.selected_option_index = (
            #     control.selected_option_index + 1
            # ) % control.options_count
            global history
            history = ""
            self.message = f"{history} {control.selected_option}"

            # control.selected_option_index = 0
            # control.reset()
            # print(control.selected_option, history)

        @kb.add("enter", eager=True)
        def set_answer(event):
            control.answered = True
            _, _, selected_option_value = control.selected_option
            event.app.exit(result=selected_option_value)

        return kb

    def _create_application(self) -> Application:
        """
        Create `Application` for this prompt.
        """
        style = Style.from_dict(
            {
                "status": "reverse",
            }
        )
        app = Application(
            layout=self.layout,
            key_bindings=self.key_bindings,
            style=style,
            full_screen=False,
        )
        return app

    def prompt(
        self,
        message: Optional[AnyFormattedText] = None,
        *,
        options: List[Option],
    ):
        # all arguments are overwritten the init arguments in SelectionPrompt.
        if message is not None:
            self.message = message
        if options is not None:
            self.options = options
            self.options_match = word_match(options)

        if self.app is None:
            self.control = SelectionControl(self.options)
            self.layout = self._create_layout()
            self.key_bindings = self._create_key_bindings()
            self.app = self._create_application()

        return self.app.run()


if __name__ == "__main__":
    p = SelectionPrompt()
    v = p.prompt(
        "choose one",
        options=[
            "apple",
            "abs",
            "banana",
            "color",
            "dict",
            "dog",
            "ear",
            "顶头没s",
            "顶头s",
            "顶头哈s",
            "顶级阿k",
        ],
    )
    print(f"you choose: {v}")
