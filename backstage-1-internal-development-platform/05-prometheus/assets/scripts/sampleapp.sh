#!/usr/bin/env bash
set -euo pipefail

cd "${HOME}/"

git clone --single-branch --branch main https://github.com/testruction/fastapi-sqlalchemy-cockroachdb sample-app

cd sample-app/

# Update Helm chart dependencies
helm dependency update ./sample-app/chart/

# Deploys the sample application
helm install --create-namespace --namespace fastapi-demo \
--set cockroachdb.statefulset.replicas="1" \
--set cockroachdb.service.public.type="LoadBalancer" \
--set cockroachdb.storage.persistentVolume.size="1Gi" \
demo ./sample-app/chart/

touch /ks/.sampleapp_finished