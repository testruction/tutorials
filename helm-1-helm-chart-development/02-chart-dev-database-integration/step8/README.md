# Automate unit tests

Create an environment variables file containing informations related to the deployed services deployed.

> **Notice**: Leveraging an external file adds a layer of security as it can typically contains credentials.

```bash
cat EOF <<EOF > ~/.env
  RELEASE_NAME="chartdev"
  BACKEND_HOST=$(kubectl get svc chartdev-fastapi-backend -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
  BACKEND_PORT=$(kubectl get svc chartdev-fastapi-backend -o jsonpath='{.spec.ports[?(@.name == "http")].nodePort}')

  FRONTEND_HOST=$(kubectl get svc chartdev-fastapi-frontend -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
  FRONTEND_PORT=$(kubectl get svc chartdev-fastapi-frontend -o jsonpath='{.spec.ports[?(@.name == "http")].nodePort}')
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

@test "Check backend health" {
  curl --fail "http://\${BACKEND_HOST}:\${PORT}/health"
}

@test "Check backend API" {
  curl --fail "http://\${BACKEND_HOST}:\${PORT}/v1/fakenames/postgres?limit=5"
}

@test "Check frontend health" {
  curl --fail "http://\${FRONTEND_HOST}:\${FRONTEND_PORT}/health"
}

@test "Check frontend UI" {
  curl --fail "http://\${FRONTEND_HOST}:\${FRONTEND_PORT}/"
}
EOF
```{{exec}}

Run the tests.

```bash
bats ~/validate.bats
```{{exec}}
