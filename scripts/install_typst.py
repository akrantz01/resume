import platform
import shutil
import subprocess
from argparse import ArgumentParser
from pathlib import Path

import httpx
from github import Asset, Release, Repository


def select_asset_for_platform(release: Release) -> Asset:
    """
    Select the appropriate typst build for the current platform.
    """

    architecture = platform.machine()
    system = platform.system().lower()
    candidates = filter(
        lambda asset: architecture in asset.name and system in asset.name,
        release.assets,
    )

    try:
        return next(candidates)
    except StopIteration:
        raise ValueError(f"No asset found for {system} {architecture}") from None


def get_release(
    client: httpx.Client,
    version: str | None = None,
    repository: str = "typst/typst",
) -> Asset:
    """
    Retrieves the download URL for the specified typst release.
    """

    repo = Repository(repository)
    release = repo.get_release(client, version)
    return select_asset_for_platform(release)


def download_typst(version: str | None = None, repository: str = "typst/typst") -> Path:
    """
    Download the specified typst release.
    """

    with httpx.Client(http1=True, http2=True) as client:
        archive = get_release(client, version, repository).download(client)

    shutil.unpack_archive(archive, archive.parent)

    executable = "typst.exe" if platform.system() == "Windows" else "typst"
    return archive.with_suffix("").with_suffix("") / executable


def move_executable(executable: Path) -> None:
    """
    Move an executable to a directory in the PATH.
    """
    try:
        shutil.move(executable, "/usr/local/bin")
        return
    except PermissionError:
        pass

    print("Could not move executable to /usr/local/bin. Trying with sudo...")
    subprocess.run(f"sudo mv {executable} /usr/local/bin", shell=True, check=True)


def install_typst_if_needed(version: str | None = None, repository: str = "typst/typst") -> None:
    """
    Install the specified typst release if it is not already installed.
    """

    executable = shutil.which("typst")
    if executable is not None:
        print(f"typst is already installed to {executable}")
        return

    executable = download_typst(version, repository)
    move_executable(executable)

    shutil.rmtree(executable.parent.parent)
    assert shutil.which("typst") is not None

    print("Installed typst to /usr/local/bin")


if __name__ == "__main__":
    parser = ArgumentParser(description="Install typst if it is not already installed.")
    parser.add_argument(
        "--repository",
        "-r",
        default="typst/typst",
        help="The repository to download from.",
    )
    parser.add_argument("--version", "-v", help="The version to download.")
    args = parser.parse_args()

    install_typst_if_needed(args.version, args.repository)
