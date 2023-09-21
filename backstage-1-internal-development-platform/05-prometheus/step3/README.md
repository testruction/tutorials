# Add Prometheus rules to components

Edit the `sample-app/src/backend/catalog-info.yaml`, then add the following annotation.

```yaml
metadata:
  annotions:
    prometheus.io/alert: >-
      demo-fastapi-backendHighErrorRate
    prometheus.io/rule: >-
      slo:objective:ratio{sloth_service="demo-fastapi-backend"}
```

Edit the `sample-app/src/frontend/catalog-info.yaml`, then add the following annotation.

```yaml
metadata:
  annotions:
    prometheus.io/alert: >-
      demo-fastapi-frontendHighErrorRate
    prometheus.io/rule: >-
      slo:objective:ratio{sloth_service="demo-fastapi-frontend"}
```

<details><summary>Do it for me</summary>

```bash
vi -e ${HOME}/sample-app/src/backend/catalog-info.yaml <<EOF
/kind: Component
/annotations
a
    prometheus.io/alert: >-
      demo-fastapi-backendHighErrorRate
    prometheus.io/rule: >-
      slo:objective:ratio{sloth_service="demo-fastapi-backend"}
.
w
EOF

vi -e ${HOME}/sample-app/src/frontend/catalog-info.yaml <<EOF
/kind: Component
/annotations
a
    prometheus.io/alert: >-
      demo-fastapi-frontendHighErrorRate
    prometheus.io/rule: >-
      slo:objective:ratio{sloth_service="demo-fastapi-frontend"}
.
w
EOF
```{{exec}}

</details>
