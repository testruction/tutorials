# Add Prometheus rules to components

Edit the `web-app/src/backend/catalog-info.yaml`, then add the following annotation.

```yaml
metadata:
  annotions:
    prometheus.io/alert: >-
      demo-fastapi-backendHighErrorRate
    prometheus.io/rule: >-
      slo:sli_error:ratio_rate5m{sloth_service="demo-fastapi-backend"}
```

Edit the `web-app/src/frontend/catalog-info.yaml`, then add the following annotation.

```yaml
metadata:
  annotions:
    prometheus.io/alert: >-
      demo-fastapi-frontendHighErrorRate
    prometheus.io/rule: >-
      slo:sli_error:ratio_rate5m{sloth_service="demo-fastapi-frontend"}
```

> **Notice**
> The **rule** and **alert** definitions were devlopped using [Sloth](https://sloth.dev) and deployed as [Prometheus Operator](prometheus-operator.dev) custom resources. Use `kubectl -n fastapi-demo get servicemonitors,prometheusrules`{{exec}} to list the monitoring ressources of the sample application or `kubectl -n fastapi-demo describe servicemonitors,prometheusrules` to review their content.

<details><summary>Do it for me</summary>

```bash
vi -e ${HOME}/web-app/src/backend/catalog-info.yaml <<EOF
/kind: Component
/annotations
a
    prometheus.io/alert: >-
      demo-fastapi-backendHighErrorRate
    prometheus.io/rule: >-
      slo:sli_error:ratio_rate5m{sloth_service="demo-fastapi-backend"}
.
w
EOF

vi -e ${HOME}/web-app/src/frontend/catalog-info.yaml <<EOF
/kind: Component
/annotations
a
    prometheus.io/alert: >-
      demo-fastapi-frontendHighErrorRate
    prometheus.io/rule: >-
      slo:sli_error:ratio_rate5m{sloth_service="demo-fastapi-frontend"}
.
w
EOF
```{{exec}}

</details>
