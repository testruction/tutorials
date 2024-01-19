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
  --path='clusters/localhost/development/kubeadm' \
  --private=false \
  --components-extra='image-reflector-controller,image-automation-controller'

kubectl apply -f ${HOME}/deploy/fluxcd/weave-gitops.yaml

touch /ks/.flux_finished
