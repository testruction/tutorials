#!/usr/bin/env bash
set -euo pipefail

kubectl apply -f ${HOME}/deploy/fluxcd/fastapi-demo.yaml

touch /ks/.webapp_finished
