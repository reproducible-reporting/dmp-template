<!--
SPDX-FileCopyrightText: 2024 RepRep's DMP Template Authors <https://github.com/reproducible-reporting/dmp-template/blob/main/AUTHORS.md>
SPDX-License-Identifier: CC-BY-NC-SA-4.0
-->

# Data Management Plan "{{ cookiecutter.short_name }}"

[![Creative Commons License](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](http://creativecommons.org/licenses/by-nc-sa/4.0/).

This repository contains the version history of the data management plan (DMP) for the project:

> {{ cookiecutter.long_name }}

The DMP is built from source with
[StepUp RepRep](https://reproducible-reporting.github.io/stepup-reprep/)
and is based on the template in the GitHub repository
[reproducible-reporting/dmp-template](https://github.com/reproducible-reporting/dmp-template).

To rebuild and work on the data management plan, `dmp.pdf`, you must have
[Git](https://git-scm.com/),
[Typst](https://github.com/typst/typst) 0.15.1,
[direnv](https://direnv.net/)
and [curl](https://curl.se/)
installed on your computer.
It is assumed that you are familiar with these tools and know how to use them.
You do not need to install Python:
the script `setup-venv-uv.sh` installs [uv](https://docs.astral.sh/uv/),
Python and the dependencies listed in `pyproject.toml` in the `.venv` directory.

The following terminal commands will clone this repository and build the PDF.

```bash
git clone git@github.com:reproducible-reporting/{{ cookiecutter.slug }}.git
cd {{ cookiecutter.slug }}
./setup-venv-uv.sh
direnv allow
pre-commit install
cd dmp
sb
```

This is a living document of which the latest Git commit contains the most up-to-date information.
No version numbers are assigned.
The generated `dmp.pdf` is automatically time-stamped with the date of the latest commit that changed `fields.yaml`.
