import platform
import shutil
from argparse import ArgumentParser
from pathlib import Path

import httpx
from github import Asset, Release, Repository

CWD = Path.cwd()


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


def install_typst_if_needed(version: str | None = None, repository: str = "typst/typst") -> None:
    """
    Install the specified typst release if it is not already installed.
    """

    destination = CWD / "typst"
    if destination.exists() and destination.is_file():
        print(f"typst is already installed at {destination}")
        return

    executable = download_typst(version, repository)
    shutil.copyfile(executable, destination)
    destination.chmod(0o755)

    shutil.rmtree(executable.parent.parent)
    assert destination.exists()

    print(f"Installed typst at {destination}")


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
