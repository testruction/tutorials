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

touch /ks/.sampledb_finished

until kubectl get svc -n fastapi-demo demo-cockroachdb-public -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
do
 echo "Waiting for database IP allocation"
 sleep 1s
done

sleep 15s

/usr/local/bin/populatedb.sh

touch /ks/.sampledb_finished
