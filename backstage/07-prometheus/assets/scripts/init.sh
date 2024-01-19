#!/usr/bin/env bash

set -euo pipefail

/ks/metallb.sh
/ks/yq.sh
/ks/nodejs.sh
/ks/locust.sh
/ks/prometheus.sh
/ks/webapp.sh &
/ks/backstageapp.sh &
