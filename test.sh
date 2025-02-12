#!/usr/bin/env bash
set -e

# Test whether the instructions in the README.md file do not generate errors.
REPO=${PWD}
WORKDIR="../nobackup/dmp-test"

if [ -d "${WORKDIR}" ]; then
    echo "Test output already exists." >&2
    rm -rvf "${WORKDIR}"
fi
mkdir -p "${WORKDIR}"

cd "${WORKDIR}"
echo > config.yaml << EOF
---
slug: test
short_name: test
long_name: Test DMP
EOF

cookiecutter ${REPO} --config-file config.yaml --no-input

cd dmp-project-short
git init
git add .
git commit -a -m "Initial commit"

./setup-venv-pip.sh
source .envrc
pre-commit install
(cd dmp; stepup)

git commit -a -m "Second commit"
