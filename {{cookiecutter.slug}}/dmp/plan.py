#!/usr/bin/env python3
from stepup.core.api import amend, copy, static, step
from stepup.reprep.api import compile_typst
from yaml import safe_load

# Manually created files used as input.
static("template.yaml", "fields.yaml")

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
    base_url = template["base_url"]
    url = f"{base_url}/{version}/dmp_template.typ"
    step(f"wget --no-clobber --quiet {url} -O dmp.typ", out="dmp.typ")

# Write the data of the latest Git commit to a yaml file.
step(
    'echo "last_updated: $(git log -1 --date=format:"%d %B %Y" --format="%ad")" > ${out}',
    out="generated.yaml",
)

# Compile the PDF.
compile_typst("dmp.typ")
