#!/usr/bin/env bash
set -euo pipefail

if [ ! -d /usr/local/pytest-sqlalchemy-cockroachdb ]
then
  git clone --single-branch \
  --branch main \
  https://github.com/testruction/pytest-sqlalchemy-cockroachdb
else
  cd /usr/local/pytest-sqlalchemy-cockroachdb
  git pull
fi

cd /usr/local/pytest-sqlalchemy-cockroachdb

pip3 install -r pytest-sqlalchemy-cockroachdb/requirements.txt

touch /ks/.sampledb_finished
