from os import environ
from pathlib import Path

CWD = Path(environ.get("BASE_DIR", Path.cwd()))
TYPST = CWD / "typst"
