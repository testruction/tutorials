#!/usr/bin/env bash
set -euo pipefail

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install --wait \
--namespace monitoring \
--create-namespace \
--set prometheus.service.type="LoadBalancer" \
default prometheus-community/kube-prometheus-stack
