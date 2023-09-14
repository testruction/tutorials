#!/usr/bin/env bash
set -euo pipefail

# Install Kind 
[ $(uname -m) = x86_64 ] \
&& curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64 \
&& chmod +x ./kind \
&& sudo mv ./kind /usr/local/bin/kind

# Install Kubernetes CLI
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
&& mv ./kubectl /usr/local/bin/kubectl \
&& chmod +x /usr/local/bin/kubectl

# Create Kind cluster
kind create cluster

touch /ks/.kind_finished
