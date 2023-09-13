# Build the Backstage production-ready container

Update the application configuration to enable PostgreSQL instead of the ephemeral SQLlite database.

```bash
yq -i '
  .backend.database.client: "pg" |
  .backend.database.connection.host: "${POSTGRES_HOST}" |
  .backend.database.connection.port: "${POSTGRES_PORT}" |
  .backend.database.connection.user: "${POSTGRES_USER}" |
  .backend.database.connection.password: "${POSTGRES_PASSWORD}"
' ./app-config.local.yaml
```{{exec}}

Merge the `app-config.local.yaml` to the `app-config.production.yaml` used when running Backstage in a container.

```bash
yq '. *= load("./app-config.local.yaml")' ./app-config.production.yaml
```

Build the backstage application.

```bash
yarn build:all
```{{exec}}

Update the container build base image tag `16-bullseye-slim` to `18-bullseye-slim`.

```bash
sed -i 's/16-bullseye-slim/18-bullseye-slim/' packages/backend/Dockerfile
```{{exec}}

```bash
docker image build . -f packages/backend/Dockerfile --tag backstage:1.0.0
```{{exec}}

Upload the generated image to the KinD cluster.

```bash
kind load docker-image backstage:1.0.0
```{{exec}}
