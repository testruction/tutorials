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

function wait_webapp()
{
    echo -n "Installing Sample App."
    while [ ! -f /ks/.webapp_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

function wait_appdb()
{
    echo -n "Installing Sample App database loader."
    while [ ! -f /ks/.appdb_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}


wait_yq
wait_nodejs
wait_docker
wait_kubeconfig
# wait_helm
wait_webapp
wait_appdb
