#!/usr/bin/env bash
set -euo pipefail

argocd app create metrics-server -f ${HOME}/deploy/argocd/metrics-server.yaml --upsert

touch /ks/.metrics-server_finished