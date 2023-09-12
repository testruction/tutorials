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
```

```bash
yarn build:backend
```

```bash
docker image build . -f packages/backend/Dockerfile --tag backstage:1.0.0
```


Run the following application in development mode.

```bash
yarn dev
```{{exec}}

[Click here]({{TRAFFIC_HOST1_3000}})  to open the Web console.
