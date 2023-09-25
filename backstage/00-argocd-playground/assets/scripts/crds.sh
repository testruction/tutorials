#!/usr/bin/env bash
set -euo pipefail

# Prometheus Operator / Kube-Prometheus
VERSION='6.0.0'
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm ugprade --install prometheus-operator-crds prometheus-community/prometheus-operator-crds --verison "${VERSION}"

touch /ks/.crds_finished