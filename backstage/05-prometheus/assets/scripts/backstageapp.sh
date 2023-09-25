#!/usr/bin/env bash
set -euo pipefail

if [ ! -d "${HOME}/backstage-tutorial" ]
then
  git clone --single-branch \
  --branch feature/kubernetes-plugin \
  https://github.com/testruction/backstage-tutorial \
  "${HOME}/backstage-tutorial"
else
  cd "${HOME}/backstage-tutorial/"
  git pull
fi

cd "${HOME}/backstage-tutorial/"

touch app-config.local.yaml

# configure backstage plugin
yq -i '
  .kubernetes.serviceLocatorMethod.type = "multiTenant" |
  .kubernetes.clusterLocatorMethods[0].type = "localKubectlProxy"
' ./app-config.local.yaml

# Retreive the KillerCoda instance URL
KC_FRONTEND_URL="$(sed -e 's/PORT/3000/' -e 's/https/http/' /etc/killercoda/host)"
KC_BACKEND_URL="$(sed 's/PORT/7007/' /etc/killercoda/host)"

export KC_FRONTEND_URL
export KC_BACKEND_URL

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
  .catalog.locations[0].target = "../../../web-app/catalog-info.yaml"
' app-config.local.yaml

touch /ks/.backstageapp_finished
