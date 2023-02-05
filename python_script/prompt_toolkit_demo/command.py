#!/usr/bin/env python3
# coding: utf-8
def test_command(*args, **kargs):
    print(args, kargs)


command_obj = {"test_command": test_command}
