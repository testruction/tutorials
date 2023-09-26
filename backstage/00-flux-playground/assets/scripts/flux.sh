#!/usr/bin/env bash
set -euo pipefail

VERSION='2.1.1'

sudo mkdir -p /opt/flux/${VERSION}
sudo wget -O /opt/flux/${VERSION}/flux_linux_amd64.tar.gz \
  https://github.com/fluxcd/flux2/releases/download/v${VERSION}/flux_${VERSION}_linux_amd64.tar.gz
tar -xvz -C /opt/flux/${VERSION} -f /opt/flux/${VERSION}/flux_linux_amd64.tar.gz
rm -vf /opt/flux/${VERSION}/flux_linux_amd64.tar.gz
sudo chmod a+x /opt/flux/${VERSION}/flux
sudo ln -sf /opt/flux/${VERSION}/flux /usr/local/bin/flux

helm repo add fluxcd-community https://fluxcd-community.github.io/helm-charts
helm repo update

helm upgrade --install \
  --wait \
  --namespace flux-system \
  --create-namespace \
  --set helmController.create="true" \
  --set imageAutomationController.create="false" \
  --set kustomizeController.create="true" \
  --set multitenancy.enabled="true" \
  --set notificationController.create="false" \
  --set prometheus.podMonitor.create="true" \
  --set sourceController.create="true" \
  --set watchAllNamespaces="true" \
  gitops fluxcd-community/flux2

touch /ks/.flux_finished
