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
wait_until_done "Installing cosign." /ks/.cosign_finished
wait_until_done "Installing crane." /ks/.crane_finished
wait_until_done "Upgrading Helm." /ks/.helm_finished
wait_until_done "Deploying the Policy Controller." /ks/.policy-controller_finished
clear
