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
sudo systemctl stop containerd
sudo systemctl stop multipathd

clear

wait_until_done "Installing YQ command line." /ks/.yq_finished
wait_until_done "Installing NodeJS 18.x." /ks/.nodejs_finished
wait_until_done "Configuring Kuberneetes client." /ks/.kubeconfig_finished
wait_until_done "Deploying Kuberneetes Custom Resource Definitions." /ks/.crds_finished
wait_until_done "Deploying Argo CD." /ks/.argocd_finished
wait_until_done "Cloning & deploying example WebApp." /ks/.argocd_finished
wait_until_done "Cloning Backstage tutorial app." /ks/.argocd_finished

sudo systemctl stop k3s
