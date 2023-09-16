#!/usr/bin/env bash
set -euo pipefail

pushd /usr/share
git clone https://github.com/bats-core/bats-core.git

cd bats-core
./install.sh /usr/local

cd ../
rm -rf bats-core

popd

touch /ks/.bats_core_finished