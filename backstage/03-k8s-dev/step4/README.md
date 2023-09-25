# Add Kubernetes plugin configuration

Edit the `backstage-tutorial/app-config.local.yaml` configuration file, the append the following settings to bastage Backstage to query the Kubernetes API server.

```yaml
kubernetes:
  serviceLocatorMethod:
    type: multiTenant
  clusterLocatorMethods:
    - type: localKubectlProxy
```{{copy}}

<details><summary>Do it for me</summary>

```bash
yq -i '
  .kubernetes.serviceLocatorMethod.type = "multiTenant" |
  .kubernetes.clusterLocatorMethods[0].type = "localKubectlProxy"
' ./app-config.local.yaml
```{{exec}}

</details>
