# Automate unit tests

Create an environment variables file containing informations related to the deployed services deployed.

> **Notice**: Leveraging an external file adds a layer of security as it typically contains credentials.

```bash
RELEASE_NAME='chartdev'

cat <<EOF > ~/.env
RELEASE_NAME="${RELEASE_NAME}"

COCKROACH_HOST=$(kubectl get nodes controlplane -o jsonpath='{.status.addresses[?(@.type == "InternalIP")].address}')
COCKROACH_PORT=$(kubectl get svc ${RELEASE_NAME}-cockroachdb-public -o jsonpath='{.spec.ports[?(@.name == "grpc")].nodePort}')

BACKEND_HOST=$(kubectl get nodes controlplane -o jsonpath='{.status.addresses[?(@.type == "InternalIP")].address}')
BACKEND_PORT=$(kubectl get svc ${RELEASE_NAME}-fastapi-backend -o jsonpath='{.spec.ports[?(@.name == "http")].nodePort}')

FRONTEND_HOST=$(kubectl get nodes controlplane -o jsonpath='{.status.addresses[?(@.type == "InternalIP")].address}')
FRONTEND_PORT=$(kubectl get svc ${RELEASE_NAME}-fastapi-frontend -o jsonpath='{.spec.ports[?(@.name == "http")].nodePort}')
EOF
```{{exec}}

Create the [bats-core](https://bats-core.readthedocs.io) unit tests file.

> **Notice**: Shell variable sign `$` must me escaped with a `\` (i.e `\$`).

```bash
cat <<EOF > ~/validate.bats
#!/usr/bin/env bats
setup() {
  load ~/.env
}

@test "Check backend health endpoint" {
    curl --retry 3 --fail "http://${BACKEND_HOST}:${BACKEND_PORT}/health"
}
@test "Check backend API" {
    curl --retry 3 --fail "http://${BACKEND_HOST}:${BACKEND_PORT}/v1/fakenames?limit=5"
}

@test "Check frontend health endpoint" {
    curl --retry 3 --fail "http://${FRONTEND_HOST}:${FRONTEND_PORT}/health"
}
@test "Check frontend/backend connectivity" {
    curl --retry 3 --fail "http://${FRONTEND_HOST}:${FRONTEND_PORT}/status"
}
@test "Check frontend UI" {
    curl --retry 3 --fail "http://${FRONTEND_HOST}:${FRONTEND_PORT}/"
}
EOF
```{{exec}}

Run the tests.

```bash
bats ~/validate.bats
```{{exec}}
