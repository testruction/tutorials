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

wait_until_done "Installing YQ command line." /ks/.yq_finished
wait_until_done "Installing Bats command line." /ks/.bats_finished
wait_until_done "Installing Node JS binaries." /ks/.nodejs_finished

