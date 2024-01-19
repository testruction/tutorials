#!/usr/bin/env bash
set -euo pipefail

argocd app create demo -f ${HOME}/deploy/argocd/fastapi-demo.yaml

touch /ks/.webapp_finished
