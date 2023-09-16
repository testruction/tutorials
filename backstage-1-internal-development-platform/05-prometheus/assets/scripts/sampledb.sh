#!/usr/bin/env bash
set -euo pipefail

cd /usr/local/

git clone --single-branch \
--branch main \
https://github.com/testruction/pytest-sqlalchemy-cockroachdb

pip3 install -r pytest-sqlalchemy-cockroachdb/requirements.txt

touch /ks/.sampledb_finished
