#!/bin/bash
set -e

# This script assumes you have a running and somewhat modern Python environment.
: "${PYTHON3:=/usr/bin/python3}"
${PYTHON3} -c 'import sys; assert sys.version_info.major == 3; assert sys.version_info.minor >= 11'

echo "Create the venv"
${PYTHON3} -m venv venv

# Create an .envrc for direnv.
cat > .envrc << 'EOL'
export SOURCE_DATE_EPOCH=315532800
source ${PWD}/venv/bin/activate
unset PS1
EOL

# Activate
source .envrc
# From now on, regular "python" can be used instead of ${PYTHON3}.
python -m pip install -U pip

# Install requirements, possibly updated after repository initialization
python -m pip install -r requirements.txt

if [[ -n "${DMP_TEMPLATE_DEBUG}" ]]; then
    # Install local development versions of StepUp Core and StepUp RePrep
    echo "Install the development version of the DMP template"
    python -m pip install -e ${DMP_TEMPLATE_DEBUG}/stepup-core -e ${DMP_TEMPLATE_DEBUG}/stepup-reprep
fi
