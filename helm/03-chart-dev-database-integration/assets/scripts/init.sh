#!/usr/bin/env bash
set -euo pipefail

function install_pkg() {
    sudo apt-get update -y

    sudo apt-get install jq nc

    touch /ks/.install_pkg
}

function install_k3s() {
    curl -sfL https://get.k3s.io | sh - 
    # Check for Ready node, takes ~30 seconds 
    sudo k3s kubectl get node

    sudo kubectl delete node ubuntu

    touch /ks/.install_k3s
}

function install_helm() {
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh

    touch /ks/.install_helm
}

function configure_kubeconfig() {
    sudo cp /etc/rancher/k3s/k3s.yaml /root/.kube/config

    touch /ks/.configure_kubeconfig
}

function install_yq(){
    sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq
    
    sudo chmod +x /usr/local/bin/yq

    touch /ks/.install_yq
}

function install_bats_core() {
    cd /usr/share
    git clone https://github.com/bats-core/bats-core.git
    
    cd bats-core
    ./install.sh /usr/local
    
    cd ../
    rm -rf bats-core
    
    cd ~/

    touch /ks/.install_bats_core
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

    touch /ks/.install_cockroach_sql
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

    touch /ks/.install_cockroach_sql
}

function install_cockroach_populate()
{
    cd ~/

    git clone https://github.com/testruction/pytest-sqlalchemy-cockroachdb

    cd pytest-sqlalchemy-cockroachdb
    pip3 install -r requirements.txt

    touch /ks/.install_cockroach_populate
}

function untaint_control_plane()
{
    kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-

    touch /ks/.untaint_control_plane
}

cat <<EOT > /root/.vimrc
set expandtab
set tabstop=2
set shiftwidth=2
EOT

# install_pkg
# install_k3s
configure_kubeconfig
# install_helm
install_yq
install_bats_core
# install_cockroach_sql
# install_cockroach
install_cockroach_populate
# untaint_control_plane