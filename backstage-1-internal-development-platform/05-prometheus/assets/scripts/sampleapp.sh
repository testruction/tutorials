#!/usr/bin/env bash
set -euo pipefail

cd "${HOME}/"

git clone --single-branch --branch main https://github.com/testruction/fastapi-sqlalchemy-cockroachdb sample-app

touch /ks/.sampleapp_finished