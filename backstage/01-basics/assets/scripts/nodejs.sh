#!/usr/bin/env bash
set -euo pipefail

# Install Node.Js (Backstage requires Node.js 24 or 26)
sudo apt-get update \
&& sudo apt-get install -y \
    'ca-certificates' \
    'curl' \
    'gnupg' \
    'build-essential' \
    'python3' \
&& sudo mkdir -p /etc/apt/keyrings \
&& curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
| sudo gpg --dearmor --yes -o /etc/apt/keyrings/nodesource.gpg

NODE_MAJOR=24
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" \
| sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt-get update \
&& sudo apt-get install nodejs -y

# Enable Yarn 4 (Berry) through Corepack.
# The Backstage app pins its own Yarn release in `.yarnrc.yml` (`yarnPath`).
sudo npm install --global corepack \
&& sudo corepack enable \
&& yarn --version

touch /ks/.nodejs_finished
