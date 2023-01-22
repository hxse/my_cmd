from prompt_toolkit import prompt
from prompt_toolkit.completion import Completer, Completion

data_list = [
    ("Katherine Davis", "105221"),
    ("Brandy Norman", "331005"),
    ("Leah Williams", "326092"),
    ("Veronica Sanchez", "104658"),
    ("Joyce Jackson", "236807"),
    ("Scott Luna", "276109"),
    ("Stephanie Fields", "712971"),
    ("Katie Griffin", "324463"),
    ("Gregory Davis", "626086"),
    ("Michael Mullins", "588486"),
]


class MyCustomCompleter(Completer):
    def __init__(self, data_list):
        self.data_list = data_list
        self.data_dict = dict(data_list)

    def get_completions(self, document, complete_event):
        matches = [name for name in self.data_dict.keys() if document.text in name]
        for m in matches:
            yield Completion(
                self.data_dict[m],
                start_position=-len(document.text_before_cursor),
                display=m,
                display_meta=self.data_dict[m],
            )


mycompleter = MyCustomCompleter(data_list)

if __name__ == "__main__":
    answer = prompt(">", completer=mycompleter)
    print("ID: %s" % answer)
