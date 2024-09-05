import httpx
from attrs import define
from cattrs import structure


@define
class Asset:
    id: int
    name: str
    browser_download_url: str


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

    _client: httpx.Client

    def __init__(self, name: str) -> None:
        try:
            self.owner, self.name = name.split("/")
        except ValueError:
            raise ValueError(f"Invalid repository name {name!r}") from None

        self._client = httpx.Client(
            base_url="https://api.github.com",
            follow_redirects=True,
            http1=True,
            http2=True,
            headers={
                "Accept": "application/vnd.github+json",
                "X-GitHub-Api-Version": "2022-11-28",
            },
        )

    def get_release(self, version: str | None = None) -> Release:
        """
        Get the release for the specified version.

        If `version` is `None`, return the latest release.
        """
        if version is None:
            return self.get_latest_release()

        response = self._client.get(
            f"/repos/{self.owner}/{self.name}/releases/tags/{version}"
        )
        if response.status_code == 404:
            raise ValueError(f"Release {version!r} not found")

        result = response.json()
        return structure(result, Release)

    def get_latest_release(self) -> Release:
        """
        Get the latest release for this repository.
        """
        result = self._client.get(
            f"/repos/{self.owner}/{self.name}/releases/latest"
        ).json()
        return structure(result, Release)

    def __del__(self) -> None:
        self._client.close()
