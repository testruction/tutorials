#!/usr/bin/env bash
set -euo pipefail

# # Uninstall non-official packages
# sudo apt-get remove -y \
#   'docker.io' \
#   'docker-compose' \
#   'containerd' \
# && rm -f /etc/containerd/config.toml \
# && sudo apt-get autoremove -y

# # Docker Installation
# # Add Docker's official GPG key:
# sudo apt-get update -y
# sudo apt-get install -y \
#   'ca-certificates' \
#   'curl' \
#   'gnupg'

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo ${VERSION_CODENAME}) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list

# sudo apt-get update -y \
# && sudo apt-get install -y \
#   'docker-ce' \
#   'docker-ce-cli' \
#   'containerd.io' \
#   'docker-buildx-plugin' \
#   'docker-compose-plugin'

sudo apt-get update -y \
&& sudo apt-get install -y \
  'docker-buildx-plugin'

touch /ks/.docker_finished
