#!/usr/bin/env python
"""Generate some fields to be used as input in the template."""

import datetime
import json
import subprocess
from urllib.request import urlopen

from stepup.core.script import driver
from yaml import safe_dump, safe_load


def info():
    return {"inp": "template.yaml", "out": "generated.yaml"}


def run(out):
    # Get info from the current commit, related to fields.
    args = ["git", "log", "-1", "--date=format:%d %B %Y", "--format=%ad"]
    cp = subprocess.run(args, capture_output=True, stdin=subprocess.DEVNULL, check=False)
    generated = {"fields_current": cp.stdout.decode().strip()}

    # Get info from the current and latest template version.
    with open("template.yaml") as fh:
        template = safe_load(fh)
    for label, version in ("current", template["version"]), ("latest", "main"):
        owner = template["github_owner"]
        repository = template["github_repository"]
        info = json.load(
            urlopen(f"https://api.github.com/repos/{owner}/{repository}/commits/{version}")
        )
        dt = datetime.datetime.fromisoformat(info["commit"]["author"]["date"])
        generated[f"template_{label}"] = dt.strftime("%d %B %Y")

    # Write YAML file.
    with open(out, "w") as fh:
        safe_dump(generated, fh)


if __name__ == "__main__":
    driver()
