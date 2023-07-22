# Deploy the chart and populate the database

Deploy the chart to the Kubernetes cluster.

```bash
helm install demo \
--set cockroachdb.public.service.type="LoadBalancer" \
--set backend.service.type="LoadBalancer" \
--set backend.service.port="8001" \
--set frontend.service.type="LoadBalancer" \
--set fronted.service.port="8000" \
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

**Links**

Access the application components using the flowing URLs.

* [CockroachDB UI]({{TRAFFIC_HOST1_8080}})
* [Backend API]({{TRAFFIC_HOST1_8001}}/v1/docs)
* [Frontend UI]({{TRAFFIC_HOST1_8000}}/)
