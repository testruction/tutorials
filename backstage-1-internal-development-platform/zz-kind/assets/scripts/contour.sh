#!/usr/bin/env bash
set -euo pipefail

kubectl label node kind-control-plane "ingress-ready=true"

kubectl apply \
-f https://projectcontour.io/quickstart/contour.yaml

kubectl patch daemonsets envoy \
-n projectcontour \
-p '{"spec":{"template":{"spec":{"nodeSelector":{"ingress-ready":"true"},"tolerations":[{"key":"node-role.kubernetes.io/control-plane","operator":"Equal","effect":"NoSchedule"},{"key":"node-role.kubernetes.io/master","operator":"Equal","effect":"NoSchedule"}]}}}}'

touch /ks/.contour_finished
