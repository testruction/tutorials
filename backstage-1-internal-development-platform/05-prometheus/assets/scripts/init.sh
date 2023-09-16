#!/usr/bin/env bash
set -euo pipefail

/ks/yq.sh
/ks/nodejs.sh
# /ks/docker.sh
/ks/kubeconfig.sh
/ks/helm.sh
# /ks/bats.sh
/ks/prometheus.sh
/ks/sampleapp.sh
/ks/sampledb.sh
/ks/backstageapp.sh
