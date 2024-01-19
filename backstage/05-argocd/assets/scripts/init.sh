#!/usr/bin/env bash

set -euo pipefail

/ks/metallb.sh
/ks/crds.sh
/ks/yq.sh
/ks/nodejs.sh
/ks/locust.sh

/ks/argocd.sh
/ks/webapp.sh &
/ks/backstageapp.sh &
