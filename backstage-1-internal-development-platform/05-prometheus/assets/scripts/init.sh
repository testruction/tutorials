#!/usr/bin/env bash
set -euo pipefail

/ks/yq.sh
/ks/nodejs.sh
# /ks/docker.sh
/ks/kubeconfig.sh
/ks/helm.sh
# /ks/bats.sh
/ks/prometheus.sh
bash -c /ks/sampleapp.sh
bash -c /ks/sampledb.sh
bash -c /ks/backstageapp.sh
