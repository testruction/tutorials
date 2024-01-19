#!/usr/bin/env bash

set -euo pipefail

# /ks/kubeconfig.sh
/ks/helm.sh
/ks/yq.sh
# /ks/nodejs.sh
/ks/locust.sh

# /ks/docker.sh &
# /ks/bats.sh &
/ks/crds.sh
/ks/metallb.sh
/ks/argocd.sh
/ks/prometheus.sh &
/ks/webapp.sh &
/ks/backstageapp.sh &
