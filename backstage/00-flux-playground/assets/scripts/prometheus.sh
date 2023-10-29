#!/usr/bin/env bash
set -euo pipefail

kubectl apply -f ${HOME}/deploy/fluxcd/kube-prometheus.yaml

touch /ks/.prometheus_finished
