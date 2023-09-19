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
  --set cockroachdb.statefulset.replicas="1" \
  --set cockroachdb.service.public.type="LoadBalancer" \
  --set cockroachdb.service.ports.http.port="18280" \
  --set cockroachdb.storage.persistentVolume.size="1Gi" \
  --set cockroachdb.serviceMonitor.enabled="true" \
  --set cockroachdb.serviceMonitor.namespaced="true" \
  --set backend.service.type="LoadBalancer" \
  --set backend.service.port="18180" \
  --set backend.serviceMonitor.enabled="true" \
  --set frontend.service.type="LoadBalancer" \
  --set frontend.service.port="18080" \
  --set frontend.serviceMonitor.enabled="true" \
  "${RL}" ./chart/

kubectl label namespace fastapi-demo "prometheus=enabled"

touch /ks/.sampleapp_finished
