import sys
import inspect


def test2(a, b, proxy="--proxy 127.0.0.1:7890"):
    """
    hello world
    """
    print(a, b, proxy)


def test(a, b, proxy="--proxy 127.0.0.1:7890"):
    """
    a: str
    b: str
    proxy: str
    pdm run python .\simple_fire.py 1 2 --proxy '--proxy \"127.0.0.1 7890\"'
    """
    print(proxy)
    print(a, b, proxy)
    # return test2(a, b,proxy=proxy)


def convert_args(argv):
    # print("args count:", len(sys.argv))
    # print("args list:", str(sys.argv))
    args = []
    kargs = []
    k_flag = False
    for i in argv:
        if i.startswith("-") and " " not in i:
            kargs.append({"key": i})
            k_flag = True
        else:
            if k_flag:
                kargs[-1]["value"] = i
                k_flag = False
            else:
                args.append(i)
    kargs = {
        i["key"].lstrip("-").replace("-", "_"): i["value"] if "value" in i else ""
        for i in kargs
    }
    return [args, kargs]


def simple_fire(data, enable_help=True):
    if type(data) == dict:
        try:
            callback = data[sys.argv[1]]
            args, kargs = convert_args(sys.argv[2:])

        except IndexError:
            raise RuntimeError(f"检测到缺少key,{data.keys()}")
        except KeyError:
            raise RuntimeError(f"检测到key不正确,{data.keys()}")
    else:
        callback = data
        args, kargs = convert_args(sys.argv[1:])

    if enable_help and ("h" in kargs.keys() or "help" in kargs.keys()):
        spec = inspect.getfullargspec(callback)
        print(f"doc: {callback.__doc__}")
        for i in spec.args[: len(spec.args) - len(spec.defaults)]:
            print("args: ", i)
        for k, v in enumerate(spec.args[len(spec.args) - len(spec.defaults) :]):
            print("kargs: ", v, spec.defaults[k])
        return
    try:
        callback(*args, **kargs)
    except TypeError as e:
        raise RuntimeError(f"{e} \n {callback.__doc__}")


if __name__ == "__main__":
    # simple_fire({"t": test}, enable_help=True)
    simple_fire(test, enable_help=True)
