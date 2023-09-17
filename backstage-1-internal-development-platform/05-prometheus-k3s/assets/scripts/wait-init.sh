#!/usr/bin/env bash
set -euo pipefail

# waits for background init to finish

rm $0

clear

function wait_yq()
{
    echo -n "Installing YQ command line."
    while [ ! -f /ks/.yq_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

function wait_nodejs()
{
    echo -n "Installing Node.JS v18 (LTS)."
    while [ ! -f /ks/.nodejs_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

function wait_docker()
{
    echo -n "Installing Docker BuildX plugin."
    while [ ! -f /ks/.docker_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}


function wait_kubeconfig()
{
    echo -n "Configuring Kubernetes client."
    while [ ! -f /ks/.kubeconfig_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
    
    kubectl get nodes
}

function wait_helm()
{
    echo -n "Installing Helm."
    while [ ! -f /ks/.helm_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

function wait_bats()
{
    echo -n "Installing Bats-Core."
    while [ ! -f /ks/.bats_core_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

function wait_prometheus()
{
    echo -n "Deploying Prometheus Operator."
    while [ ! -f /ks/.prometheus_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

function wait_sampleapp()
{
    echo -n "Installing Example App."
    while [ ! -f /ks/.sampleapp_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

function wait_sampledb()
{
    echo -n "Installing Example App database loader."
    while [ ! -f /ks/.sampledb_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

function wait_backstageapp()
{
    echo -n "Setting up Backstage application."
    while [ ! -f /ks/.backstageapp_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

function save_memory()
{
    echo "Stop unsused services to save memory"

    sudo systemctl stop k3s
    sudo systemctl stop docker
    sudo systemctl stop containerd
    sudo systemctl stop multipathd

    echo " DONE"
}

wait_yq
wait_nodejs
# wait_docker
wait_kubeconfig
# wait_helm
# wait_bats
wait_prometheus
wait_sampleapp
wait_sampledb
wait_backstageapp

save_memory