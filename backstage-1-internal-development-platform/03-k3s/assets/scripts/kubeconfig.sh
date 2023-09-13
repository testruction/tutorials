#!/usr/bin/env bash
set -euo pipefail

sudo sed -e 's/127\.0\.0\.1/localhost/' /etc/rancher/k3s/k3s.yaml \
| tee /root/.kube/config

touch /ks/.kubeconfig_finished
