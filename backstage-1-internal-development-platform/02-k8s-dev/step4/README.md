# Add Kubernetes plugin configuration

Edit the `backstage-tutorial/app-config.local.yaml` configuration file, the append the following settings to bastage Backstage to query the Kubernetes API server.

```yaml
kubernetes:
  serviceLocatorMethod:
    type: multiTenant
  clusterLocatorMethods:
    - type: config
      clusters:
        - url: kubernetes.default.svc.cluster.local:443
          name: local
          authProvider: serviceAccount
          skipTLSVerify: false
          skipMetricsLookup: true
```{{copy}}

<details><summary>Do it for me</summary>

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

</details>
