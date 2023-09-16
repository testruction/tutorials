#!/usr/bin/env bash
set -euo pipefail

git clone https://github.com/bats-core/bats-core.git

cd bats-core
./install.sh /usr/local

cd ../
rm -rf bats-core

touch /ks/.bats_core_finished