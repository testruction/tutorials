#!/usr/bin/env bash
set -euo pipefail

/ks/yq.sh
/ks/nodejs.sh
/ks/docker.sh
/ks/kubeconfig.sh
/ks/dbloader.sh