#!/usr/bin/env bash

# Memory saving
# KUBECONFIG=/etc/rancher/k3s/k3s.yaml helm uninstall -n kube-system traefik
# KUBECONFIG=/etc/rancher/k3s/k3s.yaml helm uninstall -n kube-system traefik-crd
sudo systemctl stop docker
sudo systemctl stop containerd
sudo systemctl stop multipathd
# sudo killall node  # kill theia

set -euo pipefail

# /ks/kubeconfig.sh
/ks/helm.sh
/ks/yq.sh
# /ks/nodejs.sh
/ks/locust.sh

# /ks/docker.sh &
# /ks/bats.sh &
/ks/crds.sh
/ks/metallb.sh
/ks/argocd.sh
/ks/prometheus.sh &
/ks/webapp.sh &
/ks/backstageapp.sh &
