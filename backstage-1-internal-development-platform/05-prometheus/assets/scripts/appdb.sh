#!/usr/bin/env bash
set -euo pipefail

if [ ! -d /usr/local/pytest-sqlalchemy-cockroachdb ]
then
  git clone --single-branch \
  --branch main \
  https://github.com/testruction/pytest-sqlalchemy-cockroachdb \
  /usr/local/pytest-sqlalchemy-cockroachdb
else
  cd /usr/local/pytest-sqlalchemy-cockroachdb
  git pull
fi

cd /usr/local/pytest-sqlalchemy-cockroachdb

pip3 install -r requirements.txt

touch /ks/.appdb_finished
