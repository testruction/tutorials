#!/usr/bin/env bash
set -euo pipefail

cd "${HOME}/"

git clone --single-branch \
--branch main \
https://github.com/testruction/fastapi-sqlalchemy-cockroachdb \
sample-app

# Update Helm chart dependencies
helm dependency update ./sample-app/chart/

# Deploys the sample application
helm upgrade --install \
--create-namespace \
--namespace fastapi-demo \
--set cockroachdb.statefulset.replicas="1" \
--set cockroachdb.service.public.type="LoadBalancer" \
--set cockroachdb.storage.persistentVolume.size="1Gi" \
--set cockroachdb.service.http.port="18080" \
--set cockroachdb.statefulset.resources.limits.memory="512Mi" \
--set backend.resources.limits.memory="250Mi" \
--set frontend.resources.limits.memory="250Mi" \
demo ./sample-app/chart/

touch /ks/.sampleapp_finished