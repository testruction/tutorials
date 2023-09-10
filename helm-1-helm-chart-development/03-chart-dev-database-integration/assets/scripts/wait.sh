#!/bin/bash

# waits for background init to finish

rm $0

clear

function wait_pkg()
{
    echo -n "Installing additionnal packages"
    while [ ! -f /ks/.install_pkg ]
    do
        echo -n '.'
        sleep 1s
    done
    echo " DONE"
}

function wait_k3s()
{
    echo -n "Installing k3s"
    while [ ! -f /ks/.install_k3s ]
    do
        echo -n '.'
        sleep 1s
    done
    echo " DONE"
}

function wait_helm()
{
    echo -n "Installing Helm"
    while [ ! -f /ks/.install_helm ]
    do
        echo -n '.'
        sleep 1s
    done
    echo " DONE"
}

function wait_kubeconfig()
{
    echo -n "Configuring Kubernetes client"
    while [ ! -f /ks/.configure_kubeconfig ]
    do
        echo -n '.'
        sleep 1s
    done
    echo " DONE"
}

function wait_yq()
{
    echo -n "Installing YQ"
    while [ ! -f /ks/.install_yq ]
    do
        echo -n '.'
        sleep 1s
    done
    echo " DONE"
}

function wait_bats_core()
{
    echo -n "Installing Bats-Core"
    while [ ! -f /ks/.install_bats_core ]
    do
        echo -n '.'
        sleep 1s
    done
    echo " DONE"
}

function wait_cockroach_sql()
{
    echo -n "Installing Cockroach CLI"
    while [ ! -f /ks/.install_cockroach_sql ]
    do
        echo -n '.'
        sleep 1s
    done
    echo " DONE"
}

function wait_cockroach_populate()
{
    echo -n "Retreiving Cockroach table loading scripts"
    while [ ! -f /ks/.install_cockroach_populate ]
    do
        echo -n '.'
        sleep 1s
    done
    echo " DONE"
}

function untaint_control_plane()
{
    echo -n "Removing Kubernetes control plane taints"
    while [ ! -f /ks/.untaint_control_plane ]
    do
        echo -n '.'
        sleep 1s
    done
    echo " DONE"
}

# wait_pkg
# wait_k3s
wait_kubeconfig
# wait_helm
wait_yq
wait_bats_core
# wait_cockroach_sql
# wait_cockroach
wait_cockroach_populate
# wait_control_plane

# echo -n "Initialising Kubernetes..."
# while [ ! -f /ks/.k8sfinished ]; do
#     echo -n '.'
#     sleep 1;
# done;
# echo " done"

# echo -n "Installing Argo CD..."
# while [ ! -f /ks/.initfinished ]; do
#     echo -n '.'
#     sleep 1;
# done;
# echo " done"

# echo -n "Waiting Argo CD pods to be ready, it can take up to 1 or 2 mins..."
# # check argocd server pod and verify is ready
# check_command=$(kubectl get pods -l app.kubernetes.io/name=argocd-server -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}' -n argocd)

# while [[ $check_command != True ]]; do
#     check_command=$(kubectl get pods -l app.kubernetes.io/name=argocd-server -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}' -n argocd)
#     echo -n '.'
#     sleep 1;
# done;

# echo " done"