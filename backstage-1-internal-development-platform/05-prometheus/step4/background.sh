#!/usr/bin/env bash

sudo systemctl restart k3s

until helm list -all-namespaces | grep fastapi
do
  echo waiting for sample app deployment
  sleep 1s
done

until kubectl get svc -n fastapi-demo demo-cockroachdb-public -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
do
 echo "Waiting for database IP allocation"
 sleep 1s
done

sleep 20s

/usr/local/bin/populatedb.sh

touch /ks/.sampledb_finished