#!/usr/bin/env bash
set -euo pipefail

cd /usr/local/

git clone --single-branch --branch master \
https://github.com/testruction/pytest-sqlalchemy-cockroachdb

cd pytest-sqlalchemy-cockroachdb
pip3 install -r requirements.txt

touch /ks/.dbloader_finished
