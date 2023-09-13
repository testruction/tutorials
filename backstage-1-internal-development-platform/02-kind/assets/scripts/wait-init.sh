#!/usr/bin/env bash
set -euo pipefail

# waits for background init to finish

rm $0

clear

function wait_nodejs()
{
    echo -n "Installing Node.JS v18 (LTS)."
    while [ ! -f /ks/.nodejs_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

function wait_yq()
{
    echo -n "Installing YQ command line."
    while [ ! -f /ks/.yq_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

function wait_docker()
{
    echo -n "Installing Docker Community Edition."
    while [ ! -f /ks/.docker_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

function wait_kind()
{
    echo -n "Installing Kubernetes in Docker (KinD) cluster."
    while [ ! -f /ks/.kind_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

function wait_contour()
{
    echo -n "Deploying Contour ingress controller."
    while [ ! -f /ks/.contour_finished ]; do
        echo -n '.'
        sleep 1;
    done;
    echo " DONE"
}

wait_yq
wait_nodejs
wait_docker
wait_kind
wait_contour
