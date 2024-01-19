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

/ks/github-credentials.sh

wait_until_done "Installing YQ command line." /ks/.yq_finished
wait_until_done "Installing Locust.io load generator." /ks/.locust_finished
wait_until_done "Upgrading Helm." /ks/.helm_finished
wait_until_done "Deploying MetalLB." /ks/.metallb_finished
wait_until_done "Deploying Kubernetes Custom Resource Definitions." /ks/.crds_finished
wait_until_done "Deploying Flux." /ks/.flux_finished
wait_until_done "Deploying Prometheus Operator." /ks/.prometheus_finished
wait_until_done "Cloning & deploying example WebApp." /ks/.webapp_finished
wait_until_done "Cloning Backstage tutorial app." /ks/.backstageapp_finished
