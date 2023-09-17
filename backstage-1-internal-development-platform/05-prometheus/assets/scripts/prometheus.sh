#!/usr/bin/env bash
set -euo pipefail

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm upgrade --install \
  --namespace monitoring \
  --create-namespace \
  --set prometheus.service.type="LoadBalancer" \
  --set prometheus.prometheusSpec.resources.requests.memory="100Mi" \
  --set prometheus.prometheusSpec.resources.limits.memory="500Mi" \
  default prometheus-community/kube-prometheus-stack

touch /ks/.prometheus_finished
