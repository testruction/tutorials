#!/usr/bin/env bash
set -euo pipefail

# Install Node.Js
sudo apt-get update \
&& sudo apt-get install -y \
    'ca-certificates' \
    'curl' \
    'gnupg' \
&& sudo mkdir -p /etc/apt/keyrings \
&& curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
| sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

# NODE_MAJOR=18
# echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" \
# | sudo tee /etc/apt/sources.list.d/nodesource.list

# sudo apt-get update \
# && sudo apt-get install nodejs -y

# Install NVM
NODEJS_VERSION='0.39.5'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NODEJS_VERSION}/install.sh | bash \
&& export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] \
&& \. "$NVM_DIR/nvm.sh" \
&& [ -s "$NVM_DIR/bash_completion" ] \
&& \. "$NVM_DIR/bash_completion"

# Install Node.Js
nvm install --lts \
&& nvm use --lts \
&& nvm alias default lts/*

# Install Yarn
YARN_VERSION='1.22.19'
npm install --global yarn \
&& yarn set version ${YARN_VERSION} \
&& yarn --version

NODE_OPTIONS="--max-old-space-size=1500"
export NODE_OPTIONS
echo "export NODE_OPTIONS='--max-old-space-size=1500'" | tee -a "${HOME}/.bashrc"


touch /ks/.nodejs_finished
