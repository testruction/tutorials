# Add Prometheus plugin configuration

Edit the `backstage-tutorial/app-config.local.yaml` configuration file, the append the following settings to bastage Backstage to query the Prometheus API endpoint.

```yaml
proxy:
  '/prometheus/api':
    target: http://localhost:9090/api/v1/
prometheus:
  proxyPath: /prometheus/api
```{{copy}}

<details><summary>Do it for me</summary>

```bash
yq -i '
  .proxy.'/prometheus0/api'.target = "http://localhost:9090/api/v1/" |
  .prometheus.proxyPath = "/prometheus0/api"
' ${HOME}/backstage-tutorial//app-config.local.yaml
```{{exec}}

</details>
