#!/usr/bin/env bash
set -euo pipefail

NS="${1:-fastapi-demo}"
RL="${2:-demo}"

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

until kubectl api-resources --api-group=monitoring.coreos.com
do
  echo "Waiting for Prometheus Operator"
  sleep 2s
done

# Deploys the sample application
helm upgrade --install \
  --create-namespace \
  --namespace "${NS}" \
  --set jaeger.create="false" \
  --set cockroachdb.create="false" \
  --set backend.service.type="LoadBalancer" \
  --set backend.service.port="18180" \
  --set backend.serviceMonitor.enabled="true" \
  --set backend.extraEnv[0].name="DATABASE_ENGINE" \
  --set backend.extraEnv[0].value="sqlite" \
  --set frontend.service.type="LoadBalancer" \
  --set frontend.service.port="18080" \
  --set frontend.serviceMonitor.enabled="true" \
  "${RL}" ./chart/

kubectl label namespace fastapi-demo "prometheus=enabled"

touch /ks/.sampleapp_finished
