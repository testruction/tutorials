#!/usr/bin/env bash
set -euo pipefail

helm helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

helm upgrade --install \
  --namespace argocd \
  --create-namespace \
  --set server.service.type="LoadBalancer" \
  --set controller.metrics.enabled="true" \
  --set controller.metrics.serviceMonitor="true" \
  --set dex.metrics.enabled="true" \
  --set dex.metrics.serviceMonitor="true" \
  --set redis.metrics.enabled="true" \
  --set redis.metrics.serviceMonitor="true" \
  --set server.metrics.enabled="true" \
  --set server.metrics.serviceMonitor="true" \
  --set repoServer.metrics.enabled="true" \
  --set repoServer.metrics.serviceMonitor="true" \
  --set applicationSet.metrics.enabled="true" \
  --set applicationSet.metrics.serviceMonitor="true" \
  --set notifications.metrics.enabled="true" \
  --set notifications.metrics.serviceMonitor="true"
  default argo/argo-cd

touch /ks/.argocd_finished
