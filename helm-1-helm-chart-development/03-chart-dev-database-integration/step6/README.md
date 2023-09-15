# Automate unit tests

Create an environment variables file containing informations related to the deployed services deployed.

> **Notice**: Leveraging an external file adds a layer of security as it typically contains credentials.

```bash
RELEASE_NAME='chartdev'

cat <<EOF > ~/.env
RELEASE_NAME="${RELEASE_NAME}"

COCKROACH_HOST=$(kubectl get svc ${RELEASE_NAME}-cockroachdb-public -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
COCKROACH_PORT=$(kubectl get svc ${RELEASE_NAME}-cockroachdb-public -o jsonpath='{.spec.ports[?(@.name == "grpc")].nodePort}')

BACKEND_HOST=$(kubectl get svc ${RELEASE_NAME}-fastapi-backend -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
BACKEND_PORT=$(kubectl get svc ${RELEASE_NAME}-fastapi-backend -o jsonpath='{.spec.ports[?(@.name == "http")].nodePort}')

FRONTEND_HOST=$(kubectl get svc ${RELEASE_NAME}-fastapi-frontend -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
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

@test "Check backend API" {
  curl --retry 3 --fail "http://\${BACKEND_HOST}:\${BACKEND_PORT}/health"
  curl --retry 3 --fail "http://\${BACKEND_HOST}:\${BACKEND_PORT}/v1/fakenames/postgres?limit=5"
}

@test "Check frontend UI" {
  curl --retry 3 --fail "http://\${FRONTEND_HOST}:\${FRONTEND_PORT}/health"
  curl --retry 3 --fail "http://\${FRONTEND_HOST}:\${FRONTEND_PORT}/status"
  curl --retry 3 --fail "http://\${FRONTEND_HOST}:\${FRONTEND_PORT}/"
}
EOF
```{{exec}}

Run the tests.

```bash
bats ~/validate.bats
```{{exec}}
