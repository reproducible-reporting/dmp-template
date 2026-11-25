<!--
SPDX-FileCopyrightText: 2024 RepRep's DMP Template Authors <https://github.com/reproducible-reporting/dmp-template/blob/main/AUTHORS.md>
SPDX-License-Identifier: CC-BY-NC-SA-4.0
-->

# Data Management Plan for StepUp-based Projects

[![Creative Commons License](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

This work is licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)](http://creativecommons.org/licenses/by-nc-sa/4.0/).

This repository aims to provide a data management plan for research projects
where all source data (scripts, reports, etc.) are version-controlled with Git.
The document emphasizes the use of StepUp for publication repositories,
but this is not a strict requirement.
You can also use StepUp for non-publication repositories,
e.g. to process datasets or to build computational workflows.

## Version history

The history of changes to this repository is listed in [CHANGELOG.md](CHANGELOG.md).
Version numbers are of the form `{MAJOR}.{MINOR}.{PATCH}`,
where `.{PATCH}` is omitted when it is zero:

- An increase in the major version number implies a change
  in the fields available in [`fields.yaml`](%7B%7Bcookiecutter.slug%7D%7D/dmp/fields.yaml)
  or a complete change of how the template works.
- The minor version number is increased after significant changes
  to the template (without changing the available fields or their meaning).
- The patch version number is increased after changes
  that do not affect the template or the fields,
  e.g. updates to the software environment of new DMPs.
  Versions with the same major and minor version number use the same template and fields,
  so existing DMPs do not need to be updated after a patch release.

Versions are tagged commits in the Git history.
Author contributions can also be found in the Git history.

## Creating a DMP for a new project

You must have
[Git](https://git-scm.com/),
[Typst](https://github.com/typst/typst) 0.15.1,
[direnv](https://direnv.net/),
[curl](https://curl.se/)
and [Cookiecutter](https://www.cookiecutter.io/)
installed on your computer.
It is assumed that you are familiar with these tools and know how to use them.

1. Instantiate a new DMP from the template:

   ```bash
   cookiecutter https://github.com/reproducible-reporting/dmp-template
   ```

   Follow the instructions on the screen, which will ask you to fill in some fields:

   - `slug`:
     This is a short name for the directory containing the sources and compiled outputs.
     Use only lower case letters, numbers and hyphens, no spaces.
     It is recommended to start the slug with `dmp-`.
   - `short_name`:
     A short name for the project, not too many characters, no spaces.
   - `long_name`:
     The official name of the project, e.g. from the grant application.
   - `full_name`:
     Your full name, used for copyright and authorship information.
   - `work_email`:
     Your work email address, used for copyright and authorship information.
   - `year`:
     The year of your first DMP version, used for copyright information.

1. Initialize a Git repository:

   ```bash
   cd dmp-project-short  # Use the slug you entered in the previous step.
   git init
   git add .
   git commit -a -m "Initial commit"
   ```

1. Create a software environment

   ```bash
   ./setup-venv-uv.sh
   direnv allow
   ```

   The script installs [uv](https://docs.astral.sh/uv/),
   the latest Python release and the dependencies listed in `pyproject.toml`
   in the `.venv` directory.
   No other software on your computer is modified.
   The `uv.lock` file is not tracked with Git.

1. Enable pre-commit:

   ```bash
   pre-commit install
   ```

1. Compile the `dmp.pdf` file:

   ```bash
   cd dmp
   sb
   ```

## Updating an existing DMP

Cookiecutter cannot update an existing project by itself,
but you can render a new release of the template over your DMP
and use Git to keep your own content.
The changes in each release are listed in [CHANGELOG.md](CHANGELOG.md).
Existing DMPs do not need to be updated after a patch release.

1. Commit all your changes, so `git status` shows a clean working tree.

1. Look up the answers you gave when the DMP was created:

   - `slug`: the name of the directory containing your DMP.
   - `short_name` and `long_name`: the title and the quote in your `README.md`.
   - `full_name`, `work_email` and `year`:
     the second `SPDX-FileCopyrightText` line in `dmp/fields.yaml`.

1. In the parent directory of your DMP,
   render the new release of the template over your DMP:

   ```bash
   cookiecutter https://github.com/reproducible-reporting/dmp-template \
     --checkout v3.0.2 --no-input --overwrite-if-exists \
     slug="dmp-project-short" \
     short_name="Prj-Shrt" \
     long_name="The full name of the project" \
     full_name="Your full name" \
     work_email="first.last@institution.edu" \
     year="2026"
   ```

   Replace `v3.0.2` by the release you want and the other values by your answers.

1. Review the changes with `git diff` and restore your own content.
   Cookiecutter overwrites `dmp/fields.yaml` with a copy containing `TODO` placeholders.

   ```bash
   cd dmp-project-short
   git restore dmp/fields.yaml
   ```

   If the new release adds fields, run `git restore -p dmp/fields.yaml` instead:
   discard the hunks that replace your answers with `TODO` placeholders
   and keep the hunks that add new fields.
   Do the same for other files you have modified, e.g. `README.md`.

1. Remove files that are no longer part of the template.
   Cookiecutter never deletes files, so check the changelog for removed files.
   For example, when updating from v3.0 or earlier to v3.0.1 or later:

   ```bash
   git rm requirements.txt setup-venv-pip.sh
   rm -rf venv
   ```

1. Recreate the software environment, rebuild the DMP and commit the update:

   ```bash
   ./setup-venv-uv.sh
   direnv allow
   pre-commit install
   (cd dmp; sb)
   git add -A
   git commit -m "Update to dmp-template v3.0.2"
   ```

## Contributions are welcome

If you would like to contribute, please read the general
[Guideline for Contribution to Reproducible Reporting](https://github.com/reproducible-reporting/.github/blob/main/CONTRIBUTING.md).
