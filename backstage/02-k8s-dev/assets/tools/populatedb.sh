#!/usr/bin/env bash
set -euo pipefail

sleep 15s

pushd /usr/local/pytest-sqlalchemy-cockroachdb/src

python3 -m fakenamesservice.data_loader \
--username="admin" \
--host="$(kubectl -n fastapi-demo get svc demo-cockroachdb-public -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" \
--port="$(kubectl -n fastapi-demo get svc demo-cockroachdb-public -o jsonpath='{.spec.ports[?(@.name == "grpc")].nodePort}')" \
|| popd

popd