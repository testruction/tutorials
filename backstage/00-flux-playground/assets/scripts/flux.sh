#!/usr/bin/env bash
set -euo pipefail

VERSION="2.1.2"
mkdir -p /usr/local/fluxcd/${VERSION}/
cd /usr/local/fluxcd/${VERSION}/
curl --silent --location https://github.com/fluxcd/flux2/releases/download/v${VERSION}/flux_${VERSION}_linux_amd64.tar.gz \
| tar -xvzf -
sudo ln -sf /usr/local/fluxcd/${VERSION}/flux /usr/local/bin/flux

echo -n "Waiting for GitHub personal access token (PAT)."
until grep "GITHUB_TOKEN" /tmp/.github_env > /dev/null 2>&1
do 
  echo -n '.'
  sleep 1;
done
echo " DONE"

set -o allexport
source /tmp/.github_env
set +o allexport

flux bootstrap github \
  --token-auth \
  --owner="${GITHUB_USER}" \
  --repository='fleet-infra-public' \
  --branch='main' \
  --path='clusters/localhost/development/k3s' \
  --private=false \
  --components-extra='image-reflector-controller,image-automation-controller'

VERSION="0.35.0"
mkdir -p /usr/local/gitops/${VERSION}/
cd /usr/local/gitops/${VERSION}/
curl --silent --location https://github.com/weaveworks/weave-gitops/releases/download/v${VERSION}/gitops-$(uname)-$(uname -m).tar.gz \
| tar -xvzf -
sudo ln -sf /usr/local/gitops/${VERSION}/gitops /usr/local/bin/gitops

PASSWORD="admin"
gitops create dashboard gitops \
  --password="${PASSWORD}"

touch /ks/.flux_finished
