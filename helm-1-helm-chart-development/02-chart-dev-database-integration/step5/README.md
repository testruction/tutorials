# Deploy and populate the database

Deploy the chart to the Kubernetes cluster.

```bash
helm install demo chart/
```{{exec}}

Populate the database using the dataset provided by the source code tests.

```bash
COCKROACH_HOST=$(kubectl get svc demo-cockroachdb-public -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
COCKROACH_PORT=$(kubectl get svc demo-cockroachdb-public -o jsonpath='{.spec.ports[?(@.name == "grpc")].nodePort}')
# COCKROACH_USER=$(kubectl get secret demo-fastapi-backend -o jsonpath="{.data.username}" | base64 -d)
# COCKROACH_PASSWORD=$(kubectl get secret demo-fastapi-backend -o jsonpath="{.data.password}" | base64 -d)
COCKROACH_URL="postgresql://${COCKROACH_USER}@${COCKROACH_HOST}:${COCKROACH_PORT}/postgres"

# export COCKROACH_USER
# export COCKROACH_PASSWORD
export COCKROACH_URL

# echo "${COCKROACH_PASSWORD}" | cockroach-sql --insecure -f ~/import.sql
COCKROACH_USER=admin cockroach-sql --insecure -f ~/import.sql
```
