# Deploy the chart and populate the database

Deploy the chart to the Kubernetes cluster.

```bash
helm install chartdev \
--set cockroachdb.service.public.type="LoadBalancer" \
--set backend.service.type="LoadBalancer" \
--set backend.service.port="8001" \
--set frontend.service.type="LoadBalancer" \
--set frontend.service.port="8000" \
chart/
```{{exec}}

Populate the database using the dataset provided by the source code tests.

> **Notice**: the `sleep 3s` is required to let the database clustering to finalize.

```bash
sleep 3s

COCKROACH_HOST=$(kubectl get svc chartdev-cockroachdb-public -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
COCKROACH_PORT=$(kubectl get svc chartdev-cockroachdb-public -o jsonpath='{.spec.ports[?(@.name == "grpc")].nodePort}')

cd ~/pytest-sqlalchemy-cockroachdb

python3 tests/populate.py --username="admin"

cd ~/fastapi-sqlalchemy-cockroachdb
```{{exec}}
