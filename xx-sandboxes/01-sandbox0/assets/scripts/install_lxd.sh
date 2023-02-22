#!/usr/bin/env bash
set -e

# install lxc and lxd
function install_dependencies()
{
    sudo apt-get update -y \
    && apt-get install -y \
       'lsb-release' \
       'lxd' \
       'python3-pylxd' \
       'python3-openssl'
}

# Initialize LXD
function configure_lxd()
{
    export DOWNLOAD_KEYSERVER="hkp://keyserver.ubuntu.com"

    sudo lxd init --auto
    
}

function waitfor_container()
{
  container_name="${1}"
  retry="${2:-'15'}"
  count=0

  state="Unstated yet"

  while [ "${state}" != "Running" ]
  do
    state="$(lxc info ${container_name} | grep "Status" | cut -d ' ' -f 2)"

    logger -p syslog.notice \
    "Waiting for \"${container_name}\". Current state \"${state}\""

    if [ ${count} -le ${retry} ]
    then
        logger -p syslog.error \
        "Abandoning for \"${container_name}\". Current state \"${state}\". Reason: \"Timeout\""
    fi

    ((count=count+1))
    sleep 1s
  done

  logger -p syslog.info \
  "Ready for \"${container_name}\". Current state \"${state}\""
}

function start_container()
{
    CONTAINER_NAME="${1:-'u1'}"
    USER_DATA=${2:-'/tmp/default-user-data.yml'}
    TIMEOUT="${3:-'15'}"
    DISTRIBUTION=$(lsb_release -is)
    RELEASE=$(lsb_release -cs)

    if [ "$(id -un)" = "root" ]
    then
        lxc launch "${DISTRIBUTION,,}:${RELEASE}" "${CONTAINER_NAME}" --config=user.user-data="$(cat ${USER_DATA})" --verbose

        waitfor_container ${CONTAINER_NAME} ${TIMEOUT}

        CONTAINER_IP=$(lxc info "${CONTAINER_NAME}" | grep -E "eth0\:\sinet\s.*" | awk -F " " '{print $3}')

        logger -p syslog.error \
        "Adding record to \"${CONTAINER_IP} ${CONTAINER_NAME}\" to \"/etc/hosts\""
        echo "${CONTAINER_IP} ${CONTAINER_NAME}" | sudo tee -a /etc/hosts
    fi
}

install_dependencies
configure_lxd
start_container 'lxd01' /tmp/default-user-data.yml 30
