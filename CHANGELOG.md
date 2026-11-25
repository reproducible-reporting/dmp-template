<!--
SPDX-FileCopyrightText: 2024 RepRep's DMP Template Authors <https://github.com/reproducible-reporting/dmp-template/blob/main/AUTHORS.md>
SPDX-License-Identifier: CC-BY-NC-SA-4.0
-->

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

(no changes yet)

## [3.0.1] - 2026-11-25

This release only changes the infrastructure for new DMPs.
The template (`dmp_template.typ`) and the fields in `fields.yaml` are unchanged since v3.0.

### Added

- Instructions in `README.md` for updating an existing DMP with Cookiecutter.

### Changed

- Use [uv](https://docs.astral.sh/uv/) instead of pip to create the software environment:
  `setup-venv-uv.sh` replaces `setup-venv-pip.sh`
  and `pyproject.toml` replaces `requirements.txt`.
  The script installs uv and the latest Python release in `.venv`,
  so Python no longer needs to be installed beforehand.
  The `uv.lock` file is not tracked with Git.
- Update to StepUp 4.2.0 and StepUp RepRep 4.2.0.
- `plan.py` downloads `dmp_template.typ` with curl instead of wget,
  so wget is no longer needed.
  The download is rechecked at every build.
- The `generate.py` script is also rechecked at every build.
- The template dates (current and latest) are the dates of the last commits
  that modified `dmp_template.typ`,
  and the fields date is the date of the last commit that modified `fields.yaml`.
  Changes to the infrastructure no longer affect these dates.
- Remove the redundant `©` character from the SPDX headers.
- Version numbers may have a third (patch) component,
  for changes that do not affect the template or the fields.

### Fixed

- `dmp/template.yaml` refers to the current template version.
  In v2.1 and v3.0, it still referred to v2.0,
  so DMPs created from these releases use the v2.0 template,
  unless `version` was changed manually.

## [3.0] - 2026-09-02

### Changed

- Update to StepUp 4 and Typst 0.15.1.
- Add `ruff.toml` configuration.

## [2.1] - 2026-03-30

### Added

- `AUTHORS.md` file copyright purposes

### Changed

- Update to StepUp 3.
- Refer to BtrUp for backups.
- Use REUSE.software for licensing information.
- Replace "mounting" of remote datasets by "synchronization", as this is more efficient and robust.
- Include workflows in the dataset category.
- Minor refinements to the template.

### Fixed

- Fixed minor mistake (current template date) in the template.

## [2.0] - 2025-02-13

### Changed

- Switched to Typst for PDF build.
- Automatically fill in date when the DMP is built.
- Moved template-related fields from `fields.yaml` to `template.yaml` to facilitate testing.
- New or changed fields in `template.yaml`:
  - Added `owner` for the GitHub account hosting the DMP.
  - Replaced `principal_investigators` and `other_researchers`
    with `persons` in `template.yaml`.
- Minor revisions to the template.

## [1.1] - 2024-05-24

### Changed

- Moved a few details out, and reference the relevant parts of the StepUp RepRep documentation.

## [1.0] - 2024-05-20

### Added

- Initial version, adapted from the generic DMP+ from [DMP Online](https://dmponline.be).
- A generic template for a data management plan, of which specific versions can be made
  by filling in the relevant fields with Jinja.

[1.0]: https://github.com/reproducible-reporting/dmp-template/releases/tag/v1.0
[1.1]: https://github.com/reproducible-reporting/dmp-template/releases/tag/v1.1
[2.0]: https://github.com/reproducible-reporting/dmp-template/releases/tag/v2.0
[2.1]: https://github.com/reproducible-reporting/dmp-template/releases/tag/v2.1
[3.0]: https://github.com/reproducible-reporting/dmp-template/releases/tag/v3.0
[3.0.1]: https://github.com/reproducible-reporting/dmp-template/releases/tag/v3.0.1
[unreleased]: https://github.com/reproducible-reporting/dmp-template
