<!-- markdownlint-disable no-duplicate-heading -->

# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased][]

### Fixed

- Fixed minor mistake (current template date) in the template.

## [2.0][] - 2025-02-13

### Changed

- Switched to Typst for PDF build.
- Automatically fill in date when the DMP is built.
- Moved template-related fields from `fields.yaml` to `template.yaml` to facilitate testing.
- New or changed fields in `template.yaml`:
    - Added `owener` for the GitHub account hosting the DMP.
    - Replaced `principal_investigators` and `other_researchers`
      with `persons` in `template.yaml`.
- Minor revisions to the template.

## [1.1][] - 2024-05-24

### Changed

- Moved a few details out, and reference the relevant parts of the StepUp RepRep documentation.

## [1.0][] - 2024-05-20

### Added

- Initial version, adapted from the generic DMP+ from [DMP Online](https://dmponline.be).
- A generic template for a data management plan, of which specific versions can be made
  by filling in the relevant fields with Jinja.

[Unreleased]: https://github.com/reproducible-reporting/dmp-template
[2.0]: https://github.com/reproducible-reporting/dmp-template/releases/tag/v2.0
[1.1]: https://github.com/reproducible-reporting/dmp-template/releases/tag/v1.1
[1.0]: https://github.com/reproducible-reporting/dmp-template/releases/tag/v1.0
