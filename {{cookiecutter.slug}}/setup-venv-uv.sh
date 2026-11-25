#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2024 RepRep's DMP Template Authors <https://github.com/reproducible-reporting/dmp-template/blob/main/AUTHORS.md>
# SPDX-License-Identifier: CC-BY-NC-SA-4.0

set -eo pipefail

# Everything is installed in .venv: uv, Python, the package cache and the dependencies.
# No other software is modified and the setup can be undone with `rm -rf .venv`.
# These paths are absolute because uv resolves relative paths from the current directory.
export UV_PYTHON_INSTALL_DIR="${PWD}/.venv/uv-python"
export UV_CACHE_DIR="${PWD}/.venv/cache"

echo "Install uv"
mkdir -p .venv/bin
curl -LsSf https://astral.sh/uv/install.sh | env UV_UNMANAGED_INSTALL=.venv/bin sh

echo "Create the venv with the latest Python release"
.venv/bin/uv venv --allow-existing --managed-python

# Create an .envrc for direnv.
cat > .envrc << 'EOL'
source "${PWD}/.venv/bin/activate"
export UV_PYTHON_INSTALL_DIR="${PWD}/.venv/uv-python"
export UV_CACHE_DIR="${PWD}/.venv/cache"
EOL

if [[ -z "${DMP_TEMPLATE_DEBUG}" ]]; then
    # Regular install
    echo "Install the dependencies listed in pyproject.toml"
    .venv/bin/uv sync
else
    # DMP_TEMPLATE_DEBUG can be used to test this repo against a local development version of StepUp
    echo "Install the dependencies listed in pyproject.toml, except StepUp"
    .venv/bin/uv sync --no-install-package stepup --no-install-package stepup-reprep
    echo "Install the development versions of StepUp Core and StepUp RepRep"
    .venv/bin/uv pip install \
        -e "${DMP_TEMPLATE_DEBUG}/stepup-core" \
        -e "${DMP_TEMPLATE_DEBUG}/stepup-reprep"
fi
