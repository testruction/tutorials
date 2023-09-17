#!/usr/bin/env bash
set -euo pipefail


if [ ! -d "${HOME}/sample-app" ]
then
  git clone --single-branch \
  --branch main \
  https://github.com/testruction/fastapi-sqlalchemy-cockroachdb \
  "${HOME}/sample-app"
else
  cd "${HOME}/sample-app/"
  git pull
fi

cd "${HOME}/sample-app/"

# Update Helm chart dependencies
helm dependency update ./chart/

# Deploys the sample application
helm upgrade --install \
  --create-namespace \
  --namespace fastapi-demo \
  --set cockroachdb.statefulset.replicas="1" \
  --set cockroachdb.service.public.type="LoadBalancer" \
  --set cockroachdb.service.ports.http.port="18080" \
  --set cockroachdb.storage.persistentVolume.size="1Gi" \
  --set cockroachdb.statefulset.resources.limits.memory="512Mi" \
  --set backend.service.type="LoadBalancer" \
  --set backend.service.port="28081" \
  --set backend.resources.limits.memory="250Mi" \
  --set frontend.service.type="LoadBalancer" \
  --set frontend.service.port="28080" \
  --set frontend.resources.limits.memory="250Mi" \
  demo ./chart/

sleep 15s

/usr/local/bin/populatedb.sh

touch /ks/.sampleapp_finished