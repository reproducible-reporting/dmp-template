#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2024 RepRep's DMP Template Authors <https://github.com/reproducible-reporting/dmp-template/blob/main/AUTHORS.md>
# SPDX-License-Identifier: CC-BY-NC-SA-4.0

# Test whether the instructions in the README.md file do not generate errors.
set -e

# Make a working directory
REPO="../../"
WORKDIR="tmp/dmp-test"
mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Run the cookiecutter template.
# The answers are always taken from config.yaml instead of using --replay,
# so the test does not depend on (or modify) the replay files in the home directory.
cat > config.yaml << EOF
---
default_context:
  slug: test
  short_name: test
  long_name: Test DMP
  full_name: Test User
  work_email: test.user@example.org
  year: "2525"
replay_dir: ${PWD}/replay
EOF
cookiecutter ${REPO} --config-file config.yaml --no-input --overwrite-if-exists

# Run the instructions in the README.md file
cd test
rm -rf .git
git init
git add .
git commit -a -m "Initial commit"

# Set up the virtual environment.
./setup-venv-uv.sh
source .envrc
pre-commit install

# Overwrite the template.yaml file for testing
cd dmp
cat > template.yaml << EOF
# SPDX-FileCopyrightText: 2024 RepRep's DMP Template Authors <https://github.com/reproducible-reporting/dmp-template/blob/main/AUTHORS.md>
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
version: v3.0
github_owner: reproducible-reporting
github_repository: dmp-template
local:
 - ../../${REPO}/dmp_template.typ
EOF

# Build the DMP
sb

# Try a commit
git commit -a -m "Second commit"
