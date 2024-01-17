# Deploy the chart and populate the database

Deploy the chart to the Kubernetes cluster.

```bash
helm install chartdev \
--set cockroachdb.service.public.type="NodePort" \
--set backend.service.type="NodePort" \
--set backend.service.port="8001" \
--set frontend.service.type="NodePort" \
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
--host="$(kubectl get nodes controlplane -o jsonpath='{.status.addresses[?(@.type == "InternalIP")].address}')" \
--port="$(kubectl get svc chartdev-cockroachdb-public -o jsonpath='{.spec.ports[?(@.name == "grpc")].nodePort}')"

cd ~/fastapi-sqlalchemy-cockroachdb
```{{exec}}
