#!/usr/bin/env bash
set -euo pipefail

cd ~/

git clone https://github.com/testruction/pytest-sqlalchemy-cockroachdb

cd pytest-sqlalchemy-cockroachdb/

pip3 install -r requirements.txt

touch /ks/.dbloader_finished