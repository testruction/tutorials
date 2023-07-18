#!/usr/bin/env bash

sudo wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/local/bin/yq \
&& sudo chmod +x /usr/local/bin/yq

sudo cp /etc/rancher/k3s/k3s.yaml /root/.kube/config
