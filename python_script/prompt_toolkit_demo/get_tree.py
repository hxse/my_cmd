#!/usr/bin/env python3
# coding: utf-8
import json
from config_tree import config_option


class Tree(object):
    """
    tree = Tree(option)
    result = tree.data
    tree.print_tree()
    """

    def __init__(self, option):
        self.data = self.get_option(option)

    def get_option(self, option):
        self.index = 0

        def _get_option(
            option,
            level=0,
            args={"index": 0, "number": 0, "parent": None},
        ):
            # children = [] and isEnd = True, it is express empty dir, so chilren type is list, or remove, but not None
            isEnd = (
                "children" not in option
                or option["children"] == None
                or len(option["children"]) == 0
            )
            option = {
                # "index": self.index,
                **args,
                "level": level,
                "isEnd": isEnd,
                **option,
            }
            if not isEnd:
                children = []
                level += 1
                for k, v in enumerate(option["children"]):
                    args["index"] += 1
                    args["number"] = k
                    args["parent"] = 0 if level == 1 else args["index"] - k - 1
                    children.append(_get_option(v, level=level, args=args))
                option["children"] = children
            return option

        return _get_option(option)

    def generator_list(self):
        def _generator_list(data):
            yield {
                **data,
                "children": [i["index"] for i in data["children"]],
            } if not data["isEnd"] else {**data}
            if not data["isEnd"]:
                for k, v in enumerate(data["children"]):
                    for i in _generator_list(v):
                        yield i

        return _generator_list(self.data)

    def get_from_index(self, index):
        def _get_from_index(data, index):
            if data["index"] == index:
                return data
            if not data["isEnd"]:
                for k, v in enumerate(data["children"]):
                    result = _get_from_index(
                        v,
                        index,
                    )
                    if result != None:
                        return result
            return None

        return _get_from_index(self.data, index)

    def get_from_level_number(self, level, number):
        def _get_from_level_number(data, level, number):
            if data["level"] == level and data["number"] == number:
                return data
            if "children" in data:
                for k, v in enumerate(data["children"]):
                    result = _get_from_level_number(v, level, number)
                    if result != None:
                        return result
            return None

        return _get_from_level_number(self.data, level, number)

    def get_count(self):
        def _get_count(data, count=0):
            count += 1
            if "children" in data:
                for k, v in enumerate(data["children"]):
                    count = _get_count(v, count=count)
            return count

        return _get_count(self.data)

    def get_parent(self, data):
        if data["parent"] == None:
            return None
        return self.get_from_index(data["parent"])

    def print_tree(self):

        j = json.dumps(self.data, indent=4)
        print(j)


if __name__ == "__main__":
    tree = Tree(option)
    result = tree.data
    tree.print_tree()
    # result = tree.get_from_index(4)
    # print(result)
    # result = tree.get_from_level_number(1, 1)
    # print(result)
    # result = tree.get_count()
    # print(result)
    g = tree.generator_list()
    print([i["index"] for i in list(g)])
