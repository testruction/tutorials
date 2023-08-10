#!/usr/bin/env bash
set -euo pipefail

function configure_kubeconfig() {
    sudo cp /etc/rancher/k3s/k3s.yaml /root/.kube/config
}

function install_yq(){
    sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq
    
    sudo chmod +x /usr/local/bin/yq
}

function install_bats_core() {
    cd /usr/share
    git clone https://github.com/bats-core/bats-core.git
    
    cd bats-core
    ./install.sh /usr/local
    
    cd ../
    rm -rf bats-core
    
    cd ~/
}

function install_cockroach_sql() {
    VERSION='23.1.5'

    cd /usr/share

    curl -O https://binaries.cockroachdb.com/cockroach-sql-v${VERSION}.linux-amd64.tgz
    curl -O https://binaries.cockroachdb.com/cockroach-sql-v${VERSION}.linux-amd64.tgz.sha256sum
    
    sha256sum -c cockroach-sql-v${VERSION}.linux-amd64.tgz.sha256sum

    tar -xvzf cockroach-sql-v${VERSION}.linux-amd64.tgz

    mkdir -p /usr/local/lib/cockroach
    ln -sf /usr/share/cockroach-sql-v${VERSION}.linux-amd64/lib/libgeos.so /usr/local/lib/cockroach/libgeos.so
    ln -sf /usr/share/cockroach-sql-v${VERSION}.linux-amd64/lib/libgeos_c.so /usr/local/lib/cockroach/libgeos_c.so

    ln -sf /usr/share/cockroach-sql-v${VERSION}.linux-amd64/cockroach-sql /usr/local/bin/cockroach-sql

    rm -vrf /usr/share/cockroach-sql-v${VERSION}.linux-amd64.tgz*

    cd ~/
}

function install_cockroach(){
    VERSION='23.1.5'

    cd /usr/share

    curl -O https://binaries.cockroachdb.com/cockroach-v${VERSION}.linux-amd64.tgz
    curl -O https://binaries.cockroachdb.com/cockroach-v${VERSION}.linux-amd64.tgz.sha256sum
    
    sha256sum -c cockroach-v${VERSION}.linux-amd64.tgz.sha256sum

    tar -xvzf cockroach-v${VERSION}.linux-amd64.tgz

    mkdir -p /usr/local/lib/cockroach
    ln -sf /usr/share/cockroach-v${VERSION}.linux-amd64/lib/libgeos.so /usr/local/lib/cockroach/libgeos.so
    ln -sf /usr/share/cockroach-v${VERSION}.linux-amd64/lib/libgeos_c.so /usr/local/lib/cockroach/libgeos_c.so

    ln -sf /usr/share/cockroach-v${VERSION}.linux-amd64/cockroach /usr/local/bin/cockroach

    rm -vrf /usr/share/cockroach-v${VERSION}.linux-amd64.tgz*

    cd ~/
}

function install_cockroach_populate()
{
    cd ~/

    git clone https://github.com/testruction/pytest-sqlalchemy-cockroachdb

    cd pytest-sqlalchemy-cockroachdb
    pip3 install -r requirements.txt
}

function untaint_control_plane()
{
    kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-
}

configure_kubeconfig
install_yq
install_bats_core
# install_cockroach_sql
# install_cockroach
install_cockroach_populate
# untaint_control_plane