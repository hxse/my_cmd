#!/usr/bin/env python3
# coding: utf-8
config_option = {
    "value": "root 0",
    "show": False,
    "children": [
        {
            "value": "apple is 1 apple 1",
            "args": [{"value": "--skip", "input": ""}, {"value": "--check"}],
            "help": [
                {"value": "help example1"},
                {"value": "help example2"},
                {"value": "help example3"},
                {"value": "help example4"},
                {"value": "help example5"},
                {"value": "help example6"},
                {"value": "help example7"},
                {"value": "help example8"},
                {"value": "help example9"},
                {"value": "help example10"},
                {"value": "help example11"},
                {"value": "help example12"},
                {"value": "help example13"},
                {"value": "help example14"},
                {"value": "help example15"},
                {"value": "help example16"},
                {"value": "help example17"},
                {"value": "help example18"},
                {"value": "help example19"},
                {"value": "help example20"},
                {"value": "help example21"},
                {"value": "help example22"},
                {"value": "help example23"},
                {"value": "help example24"},
                {"value": "help example25"},
                {"value": "help example26"},
            ],
            "children": [
                {
                    "value": "apple is 1.1 banana 2",
                },
                {"value": "apple is 1.2 color 3", "show": False},
            ],
        },
        {
            "value": "apple is 2 color3 4",
            "children": [
                {
                    "value": "apple is 2.1 5",
                },
                {
                    "value": "apple is 2.2 color4 6",
                    "children": [
                        {
                            "value": "apple is 2.1 7",
                            "args": [
                                {"value": "--skipfd", "input": ""},
                                {"value": "--checksd"},
                            ],
                            "help": [
                                {"value": "help examplesdf"},
                                {"value": "help example2sdf"},
                            ],
                        },
                        {
                            "abbreviation": "banana 8",
                            "value": "apple is 2.2 8",
                        },
                    ],
                },
            ],
        },
        {
            "value": "color is 2.1 9",
            "children": [
                {"value": "test 10"},
                {"value": "sdft 11"},
            ],
        },
        {"value": "color is 2.1 12", "children": []},
        {
            "value": "color is 2.1 13",
        },
        {
            "value": "color is 2.1 14",
        },
        {
            "value": "color is 2.1 15",
        },
        {
            "value": "color is 2.1 16",
        },
        {
            "value": "color is 2.1 17",
        },
        {
            "value": "color is 2.1 18",
        },
        {
            "value": "color is 2.1 19",
        },
        {
            "value": "color is 2.1 20",
        },
        {
            "value": "color is 2.1 21",
        },
        {
            "value": "col22",
        },
        {
            "value": "color is 2.1 23",
        },
        {
            "value": "color is 2.1 24",
        },
    ],
}
