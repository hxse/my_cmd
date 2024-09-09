from simple_fire import simple_fire


def convert2dIndex(
    number=3,
    step=1,
):
    result = []
    if step > number:
        result.append([0, number])
    else:
        for i in range(number // step):
            result.append([i * step, i * step + step])
        if number % step > 0:
            result.append([i * step + step, number])
    return result


def convert2d(
    array=[
        "a",
        "b",
        "c",
        "d",
        "e",
        "f",
        "g",
        "h",
        "i",
        "j",
        "k",
        "l",
        "m",
        "n",
        "o",
        "p",
        "q",
        "r",
        "s",
        "t",
        "u",
        "v",
        "w",
        "x",
        "y",
        "z",
    ],
    step=10,
):
    result = []
    for i in convert2dIndex(number=len(array), step=step):
        result.append([array[i] for i in range(i[0], i[1])])
    return result


if __name__ == "__main__":
    simple_fire(
        {
            "convert2d": convert2d,
            "convert2dIndex": convert2dIndex,
        }
    )
