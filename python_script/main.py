from anytree import Node, RenderTree
from pickpack import PickPacker, pickpack

title = "Please choose an option: "
options = [
    {
        "label": "option1",
        "abbreviation": "op1",
        "children": [
            {
                "label": "option1.1",
                "abbreviation": "op1.1",
            },
            {
                "label": "option1.2",
                "abbreviation": "op1.2",
            },
        ],
    },
    {"label": "option2", "abbreviation": "op2"},
    {"label": "option3", "abbreviation": "op3"},
]


def get_node(option):
    children = option.get("children")
    if children is not None:
        children_list: list[Node] = []
        for child in children:
            children_list.append(get_node(child))
        return Node(
            option.get("label"),
            children=children_list,
            abbreviation=option.get("abbreviation"),
        )
    else:
        return Node(
            option.get("label"), children=None, abbreviation=option.get("abbreviation")
        )


picker = PickPacker(
    options,
    title,
    indicator="*",
    options_map_func=get_node,
    output_format="nodeindex",
    multiselect=True,
    output_leaves_only=True,
)


def go_back(picker):
    return None, -1


picker.register_custom_handler(ord("h"), go_back)
picker.start()
print(picker)
