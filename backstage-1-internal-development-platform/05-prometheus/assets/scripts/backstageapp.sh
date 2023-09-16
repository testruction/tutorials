#!/usr/bin/env bash
set -euo pipefail

pushd ~/

git clone --single-branch \
--branch feature/kubernetes-plugin \
https://github.com/testruction/backstage-tutorial

cd ~/backstage-tutorial/

# configure backstage plugin
yq -i '
  .kubernetes.serviceLocatorMethod.type = "multiTenant" |
  .kubernetes.clusterLocatorMethods[0].type = "localKubectlProxy"
' ./app-config.local.yaml

# Retreive the KillerCoda instance URL
export KC_FRONTEND_URL=$(cat /etc/killercoda/host | sed -e 's/PORT/3000/' -e 's/https/http/')
export KC_BACKEND_URL=$(cat /etc/killercoda/host | sed 's/PORT/7007/')

yq -i '
  .app.listen.host = "0.0.0.0" |
  .app.listen.port = 3000 |
  .app.baseUrl = strenv(KC_FRONTEND_URL) |
  .backend.listen.host = "0.0.0.0" |
  .backend.listen.port = 7007 |
  .backend.baseUrl = strenv(KC_BACKEND_URL) |
  .backend.cors.origin = strenv(KC_FRONTEND_URL)
' ./app-config.local.yaml

# Register Sample Application entities
yq -i '
  .catalog.locations[0].type = "file" |
  .catalog.locations[0].target = "../../../sample-app/catalog-info.yaml"
' app-config.local.yaml

popd

touch /ks/.backstage_finished.yaml
