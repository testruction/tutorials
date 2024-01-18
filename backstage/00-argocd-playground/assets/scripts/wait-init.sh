#!/usr/bin/env bash
set -euo pipefail

function wait_until_done()
{
    MESSAGE="${1}"
    FILE_TO_WATCH="${2}"

    echo -n "${MESSAGE}"

    while [ ! -f "${FILE_TO_WATCH}" ]
    do
        echo -n '.'
        sleep 1
    done

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
# wait_until_done "Installing NodeJS 18.x." /ks/.nodejs_finished
# wait_until_done "Installing Bats-Core testing framework." /ks/.bats_finished
wait_until_done "Installing Locust.io load generator." /ks/.locust_finished
# wait_until_done "Installing Docker BuildX plugin" /ks/.docker_finished
# wait_until_done "Configuring Kubernetes client." /ks/.kubeconfig_finished
wait_until_done "Upgrading Helm." /ks/.helm_finished
wait_until_done "Deploying MetalLB." /ks/.metallb_finished
wait_until_done "Deploying Kubernetes Custom Resource Definitions." /ks/.crds_finished
wait_until_done "Deploying Argo CD." /ks/.argocd_finished
wait_until_done "Deploying Prometheus Operator." /ks/.prometheus_finished
wait_until_done "Cloning & deploying example WebApp." /ks/.webapp_finished
wait_until_done "Cloning Backstage tutorial app." /ks/.backstageapp_finished
