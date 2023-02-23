#!/usr/bin/env bash

set -e

# User accounts
USERNAME[0]='serena'
USERNAME[1]='ronaldo'
USERNAME[2]='ken'
USERNAME[3]='fatima'

GROUPNAME[0]='sysops'
GROUPNAME[1]='devops'
GROUPNAME[2]='finops'
GROUPNAME[3]='secops'

SHELLPATH='/bin/bash'
SHELLPATH='/bin/sh'
SHELLPATH='/bin/dash'

function create_users()
{
    for g in ${GROUPNAME[@]}
    do
        groupadd "${g}"
    done

    for u in ${USERNAME[@]}
    do
        s=$((RANDOM % ${#SHELLPATH[@]}))
        shell="${SHELLPATH[$s]}"

        g=$((RANDOM % ${#GROUPNAME[@]}))
        group="${GROUPNAME[$g]}"

        useradd --no-user-group --create-home --shell="${shell}" --groups="${group}" "${u}"

        echo "${u} ${shell} ${group}" | tee -a /var/cache/generated_users
    done
}

create_users