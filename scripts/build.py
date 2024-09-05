import subprocess
import sys
from argparse import ArgumentParser, Namespace
from pathlib import Path

from install_typst import install_typst_if_needed
from jinja2 import Environment, FileSystemBytecodeCache, FileSystemLoader, select_autoescape

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


def build_one(env: Environment, layout: str, output: Path) -> None:
    """
    Build the specified layout
    """
    print(f"Building {layout!r} layout...")
    compile(layout, output)

    template = env.get_template("viewer.html.j2")
    with (output / f"{layout}.html").open("w") as file:
        template.stream(layout=layout).dump(file)


def build_all(env: Environment, output: Path) -> None:
    """
    Build all the layouts
    """
    for layout in LAYOUTS.iterdir():
        if not (layout.is_file() and layout.suffix == ".yml"):
            continue

        build_one(env, layout.stem, output)


def create_jinja_environment() -> Environment:
    """
    Create the Jinja rendering environment
    """
    templates = Path(__file__).parent / "templates"

    cache = CWD / "__jinja_cache__"
    cache.mkdir(exist_ok=True, parents=True)

    return Environment(
        loader=FileSystemLoader(templates),
        bytecode_cache=FileSystemBytecodeCache(cache),
        autoescape=select_autoescape(),
    )


def render_redirects(env: Environment, default: str, output: Path) -> None:
    """
    Render the redirects file for Cloudflare Pages
    """
    template = env.get_template("_redirects.j2")

    with (output / "_redirects").open("w") as file:
        template.stream(default=default).dump(file)


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
    parser.add_argument(
        "--default",
        "-d",
        default="default",
        metavar="LAYOUT",
        help="The default layout",
    )
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_arguments()

    install_typst_if_needed(args.version, args.repository)

    output = Path(args.output)
    output.mkdir(exist_ok=True, parents=True)

    env = create_jinja_environment()

    if args.only:
        build_one(env, args.only, output)
        compile(args.only, output)
    else:
        build_all(env, output)

    render_redirects(env, args.default, output)
