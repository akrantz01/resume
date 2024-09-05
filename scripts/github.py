import tempfile
from pathlib import Path

import httpx
from attrs import define
from cattrs import structure

BASE_URL = "https://api.github.com"
HEADERS = {
    "Accept": "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28",
}


@define
class Asset:
    id: int
    name: str
    browser_download_url: str

    def download(self, client: httpx.Client) -> Path:
        """
        Download the asset to a temporary directory.
        """
        output = Path(tempfile.mkdtemp()) / self.name
        response = client.stream(
            method="GET",
            url=self.browser_download_url,
            headers=HEADERS,
            follow_redirects=True,
        )

        with response as stream, output.open("wb") as file:
            for chunk in stream.iter_bytes():
                file.write(chunk)

        return output


@define
class Release:
    id: int
    name: str
    tag_name: str
    assets: list[Asset]


@define
class Repository:
    owner: str
    name: str

    def __init__(self, name: str) -> None:
        try:
            self.owner, self.name = name.split("/")
        except ValueError:
            raise ValueError(f"Invalid repository name {name!r}") from None

    def get_release(self, client: httpx.Client, version: str | None = None) -> Release:
        """
        Get the release for the specified version.

        If `version` is `None`, return the latest release.
        """
        if version is None:
            return self.get_latest_release(client)

        response = client.get(
            f"{BASE_URL}/repos/{self.owner}/{self.name}/releases/tags/{version}",
            headers=HEADERS,
            follow_redirects=True,
        )
        if response.status_code == 404:
            raise ValueError(f"Release {version!r} not found")

        result = response.json()
        return structure(result, Release)

    def get_latest_release(self, client: httpx.Client) -> Release:
        """
        Get the latest release for this repository.
        """
        response = client.get(
            f"{BASE_URL}/repos/{self.owner}/{self.name}/releases/latest",
            headers=HEADERS,
            follow_redirects=True,
        )
        result = response.json()
        return structure(result, Release)
