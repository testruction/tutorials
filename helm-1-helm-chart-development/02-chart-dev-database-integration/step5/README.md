# Deploy and populate the database

Deploy the chart to the Kubernetes cluster.

```bash
helm install demo chart/
```{{exec}}

Populate the database using the dataset provided by the source code tests.

```bash
ADDR=$(kubectl get svc app-cockroachdb-public -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
PORT=$(kubectl get svc app-cockroachdb-public -o jsonpath='{.spec.ports[?(@.name == "grpc")].nodePort}')
USER=$(yq '.cockroachdb.init.provisioning.users[0].name' chart/values.yaml )
PASS=$(yq '.cockroachdb.init.provisioning.users[0].password' chart/values.yaml )

export COCKROACH_URL="postgresql://${USER}@${ADDR}:${PORT}/postgres"

echo "${PASS}" | cockroach-sql --insecure -f ~/import.sql
```
