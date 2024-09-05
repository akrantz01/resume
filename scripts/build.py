import subprocess
import sys
from argparse import ArgumentParser, Namespace
from pathlib import Path

from install_typst import install_typst_if_needed

CWD = Path.cwd()
FONTS = CWD / "fonts"
LAYOUTS = CWD / "layouts"
MAIN = CWD / "main.typ"


def compile(layout: str, output: Path) -> None:
    """
    Compile the specified layout
    """
    path = LAYOUTS / f"{layout}.yml"
    if not path.exists():
        raise ValueError(f"Layout {layout!r} does not exist")

    output = output / f"{layout}.pdf"
    result = subprocess.run(
        f"typst compile {MAIN} {output}"
        f" --input layout={path.relative_to(CWD)}"
        f" --font-path {FONTS}",
        shell=True,
    )
    if result.returncode != 0:
        sys.exit(result.returncode)


def build_all(output: Path) -> None:
    """
    Build all the layouts
    """
    for layout in LAYOUTS.iterdir():
        if not (layout.is_file() and layout.suffix == ".yml"):
            continue

        print(f"Building {layout.stem!r} layout...")
        compile(layout.stem, output)


def parse_arguments() -> Namespace:
    parser = ArgumentParser(description="Build the resume(s)")
    parser.add_argument(
        "--repository",
        "-r",
        default="typst/typst",
        help="The typst repository to download from.",
    )
    parser.add_argument("--version", "-v", metavar="TAG", help="The typst version to download")
    parser.add_argument("--only", metavar="LAYOUT", help="Only build the specified layout")
    parser.add_argument(
        "--output",
        "-o",
        default=CWD / "build",
        metavar="PATH",
        help="Where to save the output",
    )
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_arguments()

    install_typst_if_needed(args.version, args.repository)

    output = Path(args.output)
    output.mkdir(exist_ok=True, parents=True)

    if args.only:
        compile(args.only, output)
    else:
        build_all(output)
