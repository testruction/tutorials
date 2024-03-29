#!/usr/bin/env bash
set -euo pipefail

# Install Node.Js
sudo apt-get update -y

sudo apt-get install -y \
    'ca-certificates' \
    'curl' \
    'gnupg'

# Install NVM
NODEJS_VERSION='0.39.7'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NODEJS_VERSION}/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

npm install -g javascripting

touch /ks/.nodejs_finished
