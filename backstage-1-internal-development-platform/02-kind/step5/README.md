# Configure Kubernetes access for 

```bash
yq -i '
  .kubernetes.serviceLocatorMethod.type = "multiTenant" |
  .kubernetes.clusterLocatorMethods[0].type = "config" |
  .kubernetes.clusterLocatorMethods[0].clusters[0].url = "kubernetes.default.svc.cluster.local:443" |
  .kubernetes.clusterLocatorMethods[0].clusters[0].name = "local" |
  .kubernetes.clusterLocatorMethods[0].clusters[0].authProvider = "serviceAccount" |
  .kubernetes.clusterLocatorMethods[0].clusters[0].skipTLSVerify = false |
  .kubernetes.clusterLocatorMethods[0].clusters[0].skipMetricsLookup = true
' ./app-config.local.yaml
```{{exec}}

```bash
yarn build:backend
```{{exec}}

Update the container build base image tag `16-bullseye-slim` to `18-bullseye-slim`.

```bash
sed 's/16-bullseye-slim/18-bullseye-slim/' packages/backend/Dockerfile
```{{exec}}

```bash
docker image build . -f packages/backend/Dockerfile --tag backstage:1.0.0
```{{exec}}

Upload the generated image to the KinD cluster.

```bash
kind load docker-image backstage:1.0.0
```{{exec}}

[Click here]({{TRAFFIC_HOST1_3000}})  to open the Web console.
