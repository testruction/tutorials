#!/usr/bin/env bash
set -euo pipefail

sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64.tar.gz
tar xvzf yq_linux_amd64.tar.gz
./install-man-page.sh
cp -v ./yq_linux_amd64 /usr/local/bin/yq
sudo chmod +x /usr/local/bin/yq

touch /ks/.yq_finished
