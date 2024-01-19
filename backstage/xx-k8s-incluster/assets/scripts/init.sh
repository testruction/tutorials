#!/usr/bin/env bash
set -euo pipefail

/ks/yq.sh
/ks/nodejs.sh
/ks/docker.sh
/ks/metallb.sh
/ks/helm.sh
/ks/webapp.sh
/ks/appdb.sh
