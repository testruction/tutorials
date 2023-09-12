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

wait_yq
wait_nodejs

