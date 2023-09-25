#!/usr/bin/env bash
set -euo pipefail

if [ -f /etc/rancher/k3s/k3s.yaml ] && [ ! -f /root/.kube/config ]
then
    sudo sed -e 's/127\.0\.0\.1/localhost/' /etc/rancher/k3s/k3s.yaml \
    | tee /root/.kube/config

    chmod 600 /root/.kube/config
fi

sudo systemctl restart k3s
kubectl delete node ubuntu

touch /ks/.kubeconfig_finished
