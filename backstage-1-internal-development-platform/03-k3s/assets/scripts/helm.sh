#!/usr/bin/env bash
set -euo pipefail

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

ln -sf /usr/local/bin/helm /usr/bin/helm

touch /ks/.helm_finished
