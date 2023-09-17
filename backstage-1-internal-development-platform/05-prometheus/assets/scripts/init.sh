#!/usr/bin/env bash

# Memory saving
KUBECONFIG=/etc/rancher/k3s/k3s.yaml helm uninstall -n kube-system traefik
KUBECONFIG=/etc/rancher/k3s/k3s.yaml helm uninstall -n kube-system traefik-crd
sudo systemctl stop docker
sudo systemctl stop containerd
sudo systemctl stop multipathd
# sudo killall node  # kill theia

set -euo pipefail

/ks/yq.sh
/ks/nodejs.sh
# /ks/kubeconfig.sh

# /ks/docker.sh &
# /ks/helm.sh &
# /ks/bats.sh &
/ks/prometheus.sh
/ks/sampleapp.sh &
/ks/sampledb.sh &
/ks/backstageapp.sh &
