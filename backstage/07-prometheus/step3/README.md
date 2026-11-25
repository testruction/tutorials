# Add Prometheus plugin configuration
Edit the `backstage-tutorial/app-config.local.yaml` configuration file, then append the following settings to let Backstage query the Prometheus API endpoint through the backend proxy.

```yaml
proxy:
  endpoints:
    '/prometheus/api':
      target: http://localhost:9090/api/v1/
prometheus:
  proxyPath: /prometheus/api
```{{copy}}

<details><summary>Do it for me</summary>

```bash
yq -i '
  .proxy.endpoints."/prometheus/api".target = "http://localhost:9090/api/v1/" |
  .prometheus.proxyPath = "/prometheus/api"
' ${HOME}/backstage-tutorial/app-config.local.yaml
```{{exec}}

</details>
