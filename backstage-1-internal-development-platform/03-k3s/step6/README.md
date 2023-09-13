# Build the Backstage production-ready container

The container uses the `app-config.production.yaml` file which leverage PostgreSQL instead of the in-memory SQLite database engine.

Merge the `app-config.local.yaml` to the `app-config.production.yaml` used when running Backstage in a container.

```bash
yq -i '. *= load("./app-config.local.yaml")' ./app-config.production.yaml
```{{exec}}

Build the backstage application.

```bash
yarn build:backend
```{{exec}}

Update the container build base image tag `16-bullseye-slim` to `18-bullseye-slim`.

```bash
sed -i 's/16-bullseye-slim/18-bullseye-slim/' packages/backend/Dockerfile
```{{exec}}

Build the container image.

```bash
docker image build . -f packages/backend/Dockerfile --tag backstage:1.0.0
```{{exec}}

Archive the generated image.

```bash
docker save --output ~/backstage-v1.0.0.tar backstage:1.0.0
```{{exec}}

Import the image archive into the K3S cluster

```bash
k3s ctr images import ~/backstage-v1.0.0.tar \
&& rm -vf ~/backstage-v1.0.0.tar
```{{exec}}
