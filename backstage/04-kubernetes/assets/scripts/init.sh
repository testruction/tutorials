#!/usr/bin/env bash
set -euo pipefail

/ks/yq.sh
/ks/nodejs.sh
/ks/metallb.sh
/ks/webapp.sh
/ks/appdb.sh
