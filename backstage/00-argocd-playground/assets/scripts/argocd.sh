#!/usr/bin/env bash
set -euo pipefail

sudo apt-get update -y
sudo apt-get install -y apache2-utils

sudo curl -sSL -o /usr/local/bin/argocd \
  https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd

CLEAR_PWD="admin"
BCRYPT_PWD=$(htpasswd -nbBC 10 "" $CLEAR_PWD | tr -d ':\n' | sed 's/$2y/$2a/')

helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

helm upgrade --install \
  --wait \
  --namespace argo-cd \
  --create-namespace \
  --set configs.secret.argocdServerAdminPassword="${BCRYPT_PWD}" \
  --set server.extraArgs[0]="--insecure" \
  --set server.service.type="LoadBalancer" \
  --set server.service.servicePortHttp="10080" \
  --set controller.metrics.enabled="true" \
  --set controller.metrics.serviceMonitor.enabled="true" \
  --set dex.metrics.enabled="true" \
  --set dex.metrics.serviceMonitor.enabled="true" \
  --set redis.metrics.enabled="true" \
  --set redis.metrics.serviceMonitor.enabled="true" \
  --set server.metrics.enabled="true" \
  --set server.metrics.serviceMonitor.enabled="true" \
  --set repoServer.metrics.enabled="true" \
  --set repoServer.metrics.serviceMonitor.enabled="true" \
  --set applicationSet.metrics.enabled="true" \
  --set applicationSet.metrics.serviceMonitor.enabled="true" \
  --set notifications.metrics.enabled="true" \
  --set notifications.metrics.serviceMonitor.enabled="true" \
  default argo/argo-cd

argocd login  localhost:10080 --insecure --plaintext --username "admin" --password "admin"

touch /ks/.argocd_finished
