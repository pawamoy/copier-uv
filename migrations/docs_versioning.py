"""Prepare redirects from unversioned documentation URLs when updating a project."""

from __future__ import annotations

import html
import json
import os
import posixpath
import subprocess
from pathlib import Path
from tempfile import TemporaryDirectory
from urllib.parse import quote

MARKER = "<!-- copier-uv: redirects to versioned documentation -->"


def git(*args: str, check: bool = True, input: str | None = None, env: dict[str, str] | None = None) -> subprocess.CompletedProcess[str]:
    """Run Git without a shell, retaining diagnostics when a command fails."""
    return subprocess.run(["git", *args], check=check, input=input, text=True, stdout=subprocess.PIPE, env=env)


def redirect(path: str) -> str:
    """Redirect an old HTML page to its counterpart under the latest alias."""
    target = posixpath.relpath(f"latest/{path}", posixpath.dirname(path) or ".")
    if posixpath.basename(target) == "index.html":
        target = posixpath.dirname(target) + "/"
    target = quote(target, safe="/")
    escaped = html.escape(target, quote=True)
    return f"""<!doctype html>
{MARKER}
<html lang="en">
<head>
<meta charset="utf-8">
<title>Redirecting</title>
<link rel="canonical" href="{escaped}">
<script>window.location.replace({json.dumps(target)} + window.location.search + window.location.hash);</script>
<meta http-equiv="refresh" content="0; url={escaped}">
</head>
<body><a href="{escaped}">Continue to the latest documentation.</a></body>
</html>
"""


def migrate() -> None:
    """Commit redirects locally; the next release deployment publishes them."""
    branch = "refs/heads/gh-pages"
    local = git("rev-parse", "--verify", "--quiet", branch, check=False).stdout.strip()
    remote = ""
    if git("config", "--get", "remote.origin.url", check=False).returncode == 0:
        advertised = git("ls-remote", "--exit-code", "origin", branch, check=False)
        if advertised.returncode == 0:
            git("fetch", "--no-tags", "origin", branch)
            remote = git("rev-parse", "FETCH_HEAD").stdout.strip()
        elif advertised.returncode != 2:
            advertised.check_returncode()

    base = local or remote
    if local and remote and local != remote:
        if git("merge-base", "--is-ancestor", local, remote, check=False).returncode == 0:
            base = remote
        elif git("merge-base", "--is-ancestor", remote, local, check=False).returncode != 0:
            raise RuntimeError("Local and remote gh-pages branches have diverged. Reconcile them, then retry the update.")
    if not base:
        print("No gh-pages branch; documentation redirects are not needed.")
        return

    paths = git("ls-tree", "-r", "--name-only", "-z", base).stdout.split("\0")
    if "versions.json" in paths or "index.html" not in paths:
        print("No unversioned documentation to migrate.")
        return
    if MARKER in git("show", f"{base}:index.html").stdout:
        print("Documentation redirects are already prepared.")
        return
    if f"branch {branch}" in git("worktree", "list", "--porcelain").stdout.splitlines():
        raise RuntimeError("The gh-pages branch is checked out. Switch that checkout to another branch, then retry the update.")

    # A separate index preserves the project's checkout and staged template update.
    with TemporaryDirectory(prefix="copier-uv-docs-") as temporary:
        environment = {**os.environ, "GIT_INDEX_FILE": str(Path(temporary) / "index")}
        git("read-tree", base, env=environment)
        pages = [path for path in paths if path.endswith(".html") and path != "404.html"]
        for path in pages:
            blob = git("hash-object", "-w", "--stdin", input=redirect(path)).stdout.strip()
            git("update-index", "--add", "--cacheinfo", "100644", blob, path, env=environment)
        tree = git("write-tree", env=environment).stdout.strip()
        commit = git("commit-tree", tree, "-p", base, input="docs: Redirect unversioned URLs to latest\n").stdout.strip()
        git("update-ref", branch, commit, local or "0" * len(base))

    print(f"Prepared {len(pages)} redirects on local gh-pages.")
    print("Deploy release docs with `make docs-deploy version=1.2.3`.")
    print("Deploy development docs with `make docs-deploy`.")


if __name__ == "__main__":
    migrate()
