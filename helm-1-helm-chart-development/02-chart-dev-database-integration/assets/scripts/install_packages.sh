#!/usr/bin/env bash
set -euo pipefail

function configure_kubeconfig() {
    sudo cp /etc/rancher/k3s/k3s.yaml /root/.kube/config
}

function install_yq(){
    sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq \
    && sudo chmod +x /usr/local/bin/yq

    sudo cp /etc/rancher/k3s/k3s.yaml /root/.kube/config
}

function install_bats_core() {
    git clone https://github.com/bats-core/bats-core.git
    
    cd bats-core
    ./install.sh /usr/local
    
    rm -rf bats-core
}

function install_cockroach_sql() {
    VERSION='23.1.5'

    curl -O https://binaries.cockroachdb.com/cockroach-sql-v${VERSION}.linux-amd64.tgz
    curl -O https://binaries.cockroachdb.com/cockroach-sql-v${VERSION}.linux-amd64.tgz.sha256sum
    
    sha256sum -c cockroach-sql-v${VERSION}.linux-amd64.tgz.sha256sum

    tar -xvzf cockroach-sql-v${VERSION}.linux-amd64.tgz

    mkdir -p /usr/local/lib/cockroach
    cp -vi cockroach-sql-v${VERSION}.linux-amd64/lib/libgeos.so /usr/local/lib/cockroach/
    cp -vi cockroach-sql-v${VERSION}.linux-amd64/lib/libgeos_c.so /usr/local/lib/cockroach/

    cp -v cockroach-sql-v${VERSION}.linux-amd64/cockroach-sql /usr/local/bin/

    rm -vrf cockroach-sql-v${VERSION}.linux-amd64*
}

configure_kubeconfig
install_yq
install_bats_core
install_cockroach_sql
