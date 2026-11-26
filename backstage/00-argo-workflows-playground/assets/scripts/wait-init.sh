#!/usr/bin/env bash
set -euo pipefail

function wait_until_done()
{
    MESSAGE="${1}"
    FILE_TO_WATCH="${2}"
    echo -n "${MESSAGE}"
    while [ ! -f "${FILE_TO_WATCH}" ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

# waits for background init to finish

rm $0

clear

echo "Stop unsused services to save memory"
sudo systemctl stop docker

clear

wait_until_done "Upgrading Helm." /ks/.helm_finished
wait_until_done "Installing YQ command line." /ks/.yq_finished
wait_until_done "Installing NodeJS 24.x." /ks/.nodejs_finished
wait_until_done "Deploying MetalLB." /ks/.metallb_finished
wait_until_done "Deploying Argo Workflows." /ks/.argo-workflows_finished
wait_until_done "Running the demo workflows." /ks/.demo_finished
wait_until_done "Creating Backstage tutorial app." /ks/.backstageapp_finished
