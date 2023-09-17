#!/usr/bin/env bash
set -euo pipefail

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm upgrade --install \
  --namespace monitoring \
  --create-namespace \
  --set grafana.enabled="false" \
  --set kubeApiServer.enabled="false" \
  --set kubelet.enabled="false" \
  --set kubeControllerManager.enabled="false" \
  --set coreDns.enabled="false" \
  --set kubeDns.enabled="false" \
  --set kubeEtcd.enabled="false" \
  --set kubeScheduler.enabled="false" \
  --set kubeProxy.enabled="false" \
  --set kubeStateMetrics.enabled="false" \
  --set nodeExporter.enabled="false" \
  --set thanosRuller.enabled="false" \
  --set prometheus.service.type="LoadBalancer" \
  --set prometheus.prometheusSpec.resources.limits.memory="256Mi" \
  default prometheus-community/kube-prometheus-stack

touch /ks/.prometheus_finished
