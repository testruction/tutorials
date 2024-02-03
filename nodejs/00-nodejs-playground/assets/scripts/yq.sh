#!/usr/bin/env bash
set -euo pipefail

APP_VERSION="4.35.1"

mkdir -p "/opt/yq/${APP_VERSION}"

cd "/opt/yq/${APP_VERSION}/"

sudo wget https://github.com/mikefarah/yq/releases/download/v${APP_VERSION}/yq_linux_amd64.tar.gz
tar xvzf yq_linux_amd64.tar.gz
./install-man-page.sh
ln -sf /opt/yq/${APP_VERSION}/yq_linux_amd64 /usr/local/bin/yq
sudo chmod +x /usr/local/bin/yq

rm -vf yq_linux_amd64.tar.gz

touch /ks/.yq_finished
