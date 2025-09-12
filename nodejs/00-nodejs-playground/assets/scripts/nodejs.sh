#!/usr/bin/env bash
set -euo pipefail

# Install Node.Js
sudo apt-get update \
&& sudo apt-get install -y \
    'ca-certificates' \
    'curl' \
    'gnupg'

# Install NVM
NODEJS_VERSION='0.40.3'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NODEJS_VERSION}/install.sh | bash \
&& export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] \
&& \. "$NVM_DIR/nvm.sh" \
&& [ -s "$NVM_DIR/bash_completion" ] \
&& \. "$NVM_DIR/bash_completion"

# Install Node.Js
nvm install --lts \
&& corepack enable

NODE_OPTIONS="--max-old-space-size=1500"
export NODE_OPTIONS
echo "export NODE_OPTIONS='--max-old-space-size=1500'" | tee -a "${HOME}/.bashrc"

touch /ks/.nodejs_finished
