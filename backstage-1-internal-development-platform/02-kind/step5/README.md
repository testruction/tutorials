# Add Kubernetes plugin configuration

Update the application configuration to allow Backstage to access the Kubernetes cluster where it runs. 

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
