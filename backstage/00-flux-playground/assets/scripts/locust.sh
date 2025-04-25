#!/usr/bin/env bash
set -euo pipefail

apt-get install -yqq python3-locust httpie

touch /ks/.locust_finished