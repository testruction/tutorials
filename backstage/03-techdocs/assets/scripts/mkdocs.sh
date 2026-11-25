#!/usr/bin/env bash
set -euo pipefail

# Install MkDocs with the TechDocs core plugin in a Python virtual environment.
# TechDocs runs `mkdocs` locally (techdocs.generator.runIn: local).
sudo apt-get update \
&& sudo apt-get install -y \
    'python3-venv' \
    'python3-pip'

python3 -m venv "${HOME}/techdocs-venv"
"${HOME}/techdocs-venv/bin/pip" install --quiet 'mkdocs-techdocs-core'

# Make the `mkdocs` command available to the Backstage backend.
echo 'export PATH="${HOME}/techdocs-venv/bin:${PATH}"' >> "${HOME}/.bashrc"

touch /ks/.mkdocs_finished
