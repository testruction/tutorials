#!/usr/bin/env bash
set -euo pipefail

pushd ~/

git clone --single-branch \
--branch main \
https://github.com/testruction/fastapi-sqlalchemy-cockroachdb \
sample-app

popd

touch /ks/.sampleapp_finished