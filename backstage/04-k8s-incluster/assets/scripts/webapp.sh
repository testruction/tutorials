#!/usr/bin/env bash
set -euo pipefail

cd ~/

git clone --single-branch --branch main \
https://github.com/testruction/fastapi-sqlalchemy-cockroachdb \
web-app

touch /ks/.webapp_finished