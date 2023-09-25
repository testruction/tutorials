#!/usr/bin/env bash
set -euo pipefail

sudo apt-get update -y \
&& sudo apt-get install -y --no-install-recommends \
    'build-essential' \
    'make' \
    'tree'

touch /ks/.pkgs_installed
