def test(a: str, b: int = 0, c=1, *args, **kargs):
    """
    this function is on the command line!

    Args:
        haha: a required argument
        hehe: [-x] keyword-only args are options, short name is in brackets
        kaka: [-k]print kaka
    """
    print(a, b, c, *args, **kargs)


# pdm run python -m arguably .\arguably_demo\run_ypa.py  test k
# **kwargs, which is not supported
