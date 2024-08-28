import feud
import subprocess
from datetime import date


def merge_command(command):
    return " ".join([f'"{i}"' if " " in i else i for i in command])


def convert_file(inputFile, outSuffix=".mp3", enableCopy=True):
    outFile = inputFile + outSuffix
    if enableCopy:
        command = [
            "ffmpeg",
            "-i",
            f"{inputFile}",
            "-acodec",
            "copy",
            "-vcodec",
            "copy",
            f"{outFile}",
        ]
    else:
        command = [
            "ffmpeg",
            "-i",
            f"{inputFile}",
            f"{outFile}",
        ]
    print(merge_command(command))
    subprocess.run(command)


class Post(feud.Group):
    """Manage blog posts."""

    def create(id: int, *, title: str, desc: str | None = None):
        """Create a blog post."""
        print(id, title)

    def delete(*ids: int):
        """Delete blog posts."""

    def list(*, between: tuple[date, date] | None = None):
        """View all blog posts, optionally filtering by date range."""


# 没法用--world, 所以放弃了
# https://github.com/eonu/feud/issues/146
def test(hello, world="haha"):
    print(hello, world)


if __name__ == "__main__":
    feud.run({"test": test})

# if __name__ == "__main__":
#     feud.run({"cf": convert_file, "test": test, "post": Post})
