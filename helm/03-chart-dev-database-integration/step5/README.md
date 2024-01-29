# Deploy the chart and populate the database

Deploy the chart to the Kubernetes cluster.

```bash
helm upgrade --install chartdev \
--set cockroachdb.service.public.type="LoadBalancer" \
--set cockroachdb.service.public."annotations.metallb\.universe\.tf/allow-shared-ip"="edge-endpoint" \
--set backend.service.type="LoadBalancer" \
--set backend.service.port="8001" \
--set frontend.service.type="LoadBalancer" \
--set frontend.service.port="8000" \
chart/
```{{exec}}

Populate the database using the dataset provided by the source code tests.

> **Notice**: The `sleep 15s` is required to let the database clustering to finalize.

```bash
sleep 15s

cd ~/pytest-sqlalchemy-cockroachdb/src

python3 -m fakenamesservice.data_loader \
--username="admin" \
--host="$(kubectl get svc chartdev-cockroachdb-public -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" \
--port="$(kubectl get svc chartdev-cockroachdb-public -o jsonpath='{.spec.ports[?(@.name == "grpc")].nodePort}')"

cd ~/fastapi-sqlalchemy-cockroachdb
```{{exec}}

```bash
kubectl patch svc chartdev-fastapi-backend \
--type='json' \
--patch='[{"op": "add", "path": "/metadata/annotations/metallb.universe.tf~1allow-shared-ip", "value":"edge-endpoint"}]'

kubectl patch svc chartdev-fastapi-frontend \
--type='json' \
--patch='[{"op": "add", "path": "/metadata/annotations/metallb.universe.tf~1allow-shared-ip", "value":"edge-endpoint"}]'
```{{exec}}