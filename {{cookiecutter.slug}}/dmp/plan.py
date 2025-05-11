#!/usr/bin/env python3
from stepup.core.api import amend, copy, runsh, script, static
from stepup.reprep.api import compile_typst
from yaml import safe_load

# Manually created files used as input.
static("template.yaml", "fields.yaml", "generate.py")

# Get template information.
amend(inp="template.yaml")
with open("template.yaml") as fh:
    template = safe_load(fh)

# Copy or download the template.
if "local" in template:
    static(template["local"])
    copy(template["local"][-1], "dmp.typ")
else:
    version = template["version"]
    owner = template["github_owner"]
    repository = template["github_repository"]
    url = f"https://raw.githubusercontent.com/{owner}/{repository}/{version}/dmp_template.typ"
    runsh(f"wget --no-clobber --quiet {url} -O dmp.typ", out="dmp.typ")

# Write the data of the latest Git commit to a yaml file.
script("generate.py")

# Compile the PDF.
compile_typst("dmp.typ")
