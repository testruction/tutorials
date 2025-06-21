#!/usr/bin/env bash

set -euo pipefail

/ks/helm.sh
/ks/yq.sh
/ks/locust.sh

/ks/crds.sh
/ks/metallb.sh
/ks/argocd.sh
/ks/prometheus.sh &
/ks/metrics-server.sh &
/ks/webapp.sh &
/ks/backstageapp.sh &
