#!/usr/bin/env bash
set -euo pipefail

# Install NVM
NODEJS_VERSION='0.39.5'
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v${NODEJS_VERSION}/install.sh | bash \
&& source ~/.bashrc

# Install Node.Js
nvm install 18 \
&& nvm use 18 \
&& nvm alias default 18

# Install Yarn
YARN_VERSION='1.22.19'
npm install --global yarn \
&& yarn set version ${YARN_VERSION} \
&& yarn --version


touch /ks/.nodejs_installed
