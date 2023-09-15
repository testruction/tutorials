#!/usr/bin/env bash
set -euo pipefail

sleep 15s

cd /usr/local/pytest-sqlalchemy-cockroachdb/src

python3 -m fakenamesservice.data_loader \
--username="admin" \
--host="$(kubectl get svc chartdev-cockroachdb-public -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" \
--port="$(kubectl get svc chartdev-cockroachdb-public -o jsonpath='{.spec.ports[?(@.name == "grpc")].nodePort}')"
