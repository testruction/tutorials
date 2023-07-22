# Deploy the chart and populate the database

Deploy the chart to the Kubernetes cluster.

```bash
helm install demo \
--set frontent.ingress.enabled=true \
--set frontend.ingress.host[0].host="*"
--set frontend.ingress.host[0].host.path=""
chart/
```{{exec}}

Populate the database using the dataset provided by the source code tests.

```bash
COCKROACH_HOST=$(kubectl get svc demo-cockroachdb-public -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
COCKROACH_PORT=$(kubectl get svc demo-cockroachdb-public -o jsonpath='{.spec.ports[?(@.name == "grpc")].nodePort}')

cd ~/pytest-sqlalchemy-cockroachdb

python3 tests/populate.py --username="admin"

cd ~/fastapi-sqlalchemy-cockroachdb
```{{exec}}

[CockroachDB UI]({{TRAFFIC_HOST1_8080}})
[click here]({{TRAFFIC_HOST1_8080}})