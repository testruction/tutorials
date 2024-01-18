#!/usr/bin/env bash

set -euo pipefail

helm repo add metallb https://metallb.github.io/metallb

helm upgrade --install metallb \
  --namespace metallb-system --create-namespace \
  --wait \
  metallb/metallb

cat <<EOF | tee /ks/ip-address-pool.yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default-pool
  namespace: metallb-system
spec:
  addresses:
  - 172.30.1.2/32
EOF

kubectl apply -f /ks/ip-address-pool.yaml

touch /ks/.dbloader_finished