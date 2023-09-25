#!/usr/bin/env bash
set -euo pipefail

sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq
sudo chmod +x /usr/local/bin/yq

touch /ks/.yq_finished
