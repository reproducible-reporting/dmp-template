#!/usr/bin/env bash
# SPDX-FileCopyrightText: © 2024 RepRep's DMP Template Authors <https://github.com/reproducible-reporting/dmp-template/blob/main/AUTHORS.md>
# SPDX-License-Identifier: CC-BY-NC-SA-4.0

# Test whether the instructions in the README.md file do not generate errors.
set -e

# Make a working directory
REPO="../../$(basename ${PWD})"
WORKDIR="../nobackup/dmp-test"

# Run the cookiecutter template
if [ -d "${WORKDIR}" ]; then
  cd "${WORKDIR}"
  cookiecutter ${REPO} --replay --overwrite-if-exists
else
  mkdir -p "${WORKDIR}"
  cd "${WORKDIR}"
  echo > config.yaml << EOF
---
slug: test
short_name: test
long_name: Test DMP
full_name: Test User
work_email: test.user@example.org
year: 2525
EOF

  cookiecutter ${REPO} --config-file config.yaml --no-input
fi

# Run the instructions in the README.md file
cd dmp-project-short
rm -rf .git
git init
git add .
git commit -a -m "Initial commit"

# Set up the virtual environment.
./setup-venv-pip.sh
source .envrc
pre-commit install

# Overwrite the template.yaml file for testing
cd dmp
cat > template.yaml << EOF
# SPDX-FileCopyrightText: © 2024 RepRep's DMP Template Authors <https://github.com/reproducible-reporting/dmp-template/blob/main/AUTHORS.md>
# SPDX-License-Identifier: CC-BY-NC-SA-4.0
version: v2.0
github_owner: reproducible-reporting
github_repository: dmp-template
local:
 - ../../${REPO}/dmp_template.typ
EOF

# Build the DMP
stepup boot

# Try a commit
git commit -a -m "Second commit"
