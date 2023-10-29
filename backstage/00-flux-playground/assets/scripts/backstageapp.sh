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
BS_ARGO_TOKEN=$(argocd account generate-token --account backstage)

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
  .kubernetes.clusterLocatorMethods[0].type = "localKubectlProxy" |
  .argocd.username = "admin" |
  .argocd.password = "admin" |
  .argocd.appLocatorMethods[0].type = "config" |
  .argocd.appLocatorMethods[0].instances[0].name = "argocd" |
  .argocd.appLocatorMethods[0].instances[0].url = "http://localhost:10080" |
  .argocd.appLocatorMethods[0].instances[0].token = strenv(BS_ARGO_TOKEN)
' ./app-config.local.yaml


# Customize Flux CD application deployment
# ----------------------------------------
KC_URL=$(sed 's/PORT/8008/' /etc/killercoda/host)

kubectl create namespace backstage

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: killercoda-env
  namespace: backstage
data:
  FRONTEND_URL: ${KC_URL}
  BACKEND_URL: ${KC_URL}
EOF

unset BS_ARGO_TOKEN

kubectl apply -f ${HOME}/deploy/fluxcd/backstage.yaml

touch /ks/.backstageapp_finished
