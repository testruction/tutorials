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

wait_until_done "Installing YQ command line." /ks/.yq_finished
wait_until_done "Installing BATS Core command line." /ks/.bats_core_finished