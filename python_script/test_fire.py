import fire


# def parse(str):
#     print(str, 233)
#     return str


# # @fire.decorators.SetParseFn(parse)
def test(a, b):
    # https://github.com/google/python-fire/issues/459
    # 有些问题, 跟默认args不一致, '\"2 3\"' 会报错, 所以不用fire了, 用simple_fire
    print(a, b)


if __name__ == "__main__":
    fire.Fire(test)
