#!/usr/bin/env bash
set -euo pipefail

sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq \
&& sudo chmod +x /usr/local/bin/yq

sudo cp /etc/rancher/k3s/k3s.yaml /root/.kube/config

git clone https://github.com/bats-core/bats-core.git
cd bats-core
./install.sh /usr/local
rm -rf bats-core
