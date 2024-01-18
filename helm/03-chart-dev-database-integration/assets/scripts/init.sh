#!/usr/bin/env bash

set -euo pipefail

/ks/yq.sh &
/ks/bats.sh &
/ks/dbloader.sh &
/ks/metallb.sh &