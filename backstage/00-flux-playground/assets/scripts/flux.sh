#!/usr/bin/env bash
set -euo pipefail

VERSION="2.1.2"
mkdir -p /usr/local/fluxcd/${VERSION}/
cd /usr/local/fluxcd/${VERSION}/
curl -OfsSL https://github.com/fluxcd/flux2/releases/download/v${VERSION}/flux_${VERSION}_linux_amd64.tar.gz | tar -xvzf -
sudo ln -sf /usr/local/fluxcd/${VERSION}/flux /usr/local/bin/flux

flux install

cat <<EOF | kubectl apply -f -


---
apiVersion: kustomize.toolkit.fluxcd.io/v1beta2
kind: Kustomization
metadata:
  name: fsa-demo
  namespace: flux-system
spec:
  prune: true
  interval: 2m
  path: "./demo"
  sourceRef:
    kind: OCIRepository
    name: fsa-demo
  timeout: 3m
EOF

# argocd login  localhost:10080 --insecure --plaintext --username "admin" --password "${ADMIN_PWD}"

# # GitOps account
# kubectl -n argo-cd patch configmap/argocd-cm \
# --type='json' \
# --patch '[{"op": "add", "path": "/data/accounts.sysops", "value": "apiKey,login"}]'

# # Backstage account
# kubectl -n argo-cd patch configmap/argocd-cm \
# --type='json' \
# --patch '[{"op": "add", "path": "/data/accounts.backstage", "value": "apiKey,login"}]'

# # Account RBAC
# kubectl -n argo-cd patch configmap/argocd-rbac-cm \
# --type='json' \
# --patch '[{"op": "add", "path": "/data/policy.csv", "value": "g, sysops, role:admin\ng, backstage, role:readonly\n"}]'

touch /ks/.flux_finished
