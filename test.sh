#!/usr/bin/env bash
set -e

# Test whether the instructions in the README.md file do not generate errors.
REPO=${PWD}
TMP_DIR="$(mktemp -d)"

if [ -d "${TMP_DIR}" ]; then
    trap "rm -rf -- '$TMP_DIR'" EXIT
else
    echo "Failed to create a temporary directory." >&2
    exit 1
fi

cd "${TMP_DIR}"
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
stepup

git commit -a -m "Second commit"
