#!/usr/bin/env bash
set -euo pipefail

# Customize Backstage for dev mode
# ----------------------------------------
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

# Retreive the KillerCoda instance URL
KC_FRONTEND_URL="$(sed -e 's/PORT/3000/' -e 's/https/http/' /etc/killercoda/host)"
KC_BACKEND_URL="$(sed 's/PORT/7007/' /etc/killercoda/host)"

export KC_FRONTEND_URL
export KC_BACKEND_URL
export BS_ARGO_TOKEN

cd "${HOME}/backstage-tutorial/"
touch app-config.local.yaml

# Customize local configuration
yq -i '
  .app.listen.host = "0.0.0.0" |
  .app.listen.port = 3000 |
  .app.baseUrl = strenv(KC_FRONTEND_URL) |
  .backend.listen.host = "0.0.0.0" |
  .backend.listen.port = 7007 |
  .backend.baseUrl = strenv(KC_BACKEND_URL) |
  .backend.cors.origin = strenv(KC_FRONTEND_URL) |
  .catalog.locations[0].type = "file" |
  .catalog.locations[0].target = "../../../web-app/catalog-info.yaml" |
  .kubernetes.serviceLocatorMethod.type = "multiTenant" |
  .kubernetes.clusterLocatorMethods[0].type = "localKubectlProxy"
' ./app-config.local.yaml


# Customize Flux CD application deployment
# ----------------------------------------
KC_URL=$(sed 's/PORT/7007/' /etc/killercoda/host)

kubectl create namespace backstage \
  -o yaml --dry-run=client > ${HOME}/deploy/backsage-namespace.yaml
kubectl apply -f ${HOME}/deploy/backsage-namespace.yaml

kubectl -n backstage create secret generic killercoda-env \
  --from-literal="FRONTEND_URL=${KC_URL}" \
  --from-literal="BACKEND_URL=${KC_URL}" \
  --dry-run=client -o yaml > ${HOME}/deploy/killercoda-secret.yaml
kubectl apply -f ${HOME}/deploy/killercoda-secret.yaml


kubectl apply -f ${HOME}/deploy/fluxcd/backstage.yaml

touch /ks/.backstageapp_finished
