#!/usr/bin/env bash

set -euo pipefail

argocd app create kube-prometheus -f ~/deploy/argocd/kube-prometheus.yaml --upsert

touch /ks/.prometheus_finished
