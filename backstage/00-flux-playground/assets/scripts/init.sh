#!/usr/bin/env bash

set -euo pipefail

/ks/helm.sh
/ks/metallb.sh

/ks/yq.sh
/ks/locust.sh

/ks/crds.sh
/ks/flux.sh
/ks/prometheus.sh &
/ks/webapp.sh &
/ks/backstageapp.sh &
