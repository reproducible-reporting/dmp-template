#!/usr/bin/env python3
from yaml import safe_load
from stepup.core.api import static, step, amend
from stepup.reprep.api import render_jinja, convert_markdown, convert_weasyprint

# Get the version number from the fields file.
static("fields.yaml")
amend(inp="fields.yaml")
with open("fields.yaml") as fh:
    fields = safe_load(fh)

# Download the right template.
version = fields["dmp_template_version"]
url = (
    "https://raw.githubusercontent.com/reproducible-reporting/dmp-template/"
    f"{version}/dmp_template.md"
)
step(f"wget --no-clobber --quiet {url}", out="dmp_template.md")

# Render the PDF.
static("fields.py", "style.css")
render_jinja("dmp_template.md", ["fields.py"], "dmp.md")
convert_markdown("dmp.md")
convert_weasyprint("dmp.html")
