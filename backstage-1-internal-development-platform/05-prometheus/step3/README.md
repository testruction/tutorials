# Add Prometheus rules to components

Edit the `sample-app/src/backend/catalog-info.yaml`, then add the following annotation.

```yaml
metadata:
  annotions:
    prometheus.io/rule: >
      (sum(rate(http_requests_total{job="demo-fastapi-backend",status=~"5..|429"}[5m])))
      /
      (sum(rate(http_requests_total{job="demo-fastapi-backend"}[5m])))
```

Edit the `sample-app/src/frontend/catalog-info.yaml`, then add the following annotation.

```yml
metadata:
  annotions:
    prometheus.io/rule: >
      (sum(rate(http_requests_total{job="demo-fastapi-frontend",status=~"5..|429"}[5m])))
      /
      (sum(rate(http_requests_total{job="demo-fastapi-frontend"}[5m])))
```

<details><summary>Do it for me</summary>

```bash
vi -e ${HOME}/sample-app/src/backend/catalog-info.yaml <<EOF
/kind: Component
/annotations
a
    prometheus.io/rule: >
      (sum(rate(http_requests_total{job="demo-fastapi-backend",status=~"5..|429"}[5m])))
      /
      (sum(rate(http_requests_total{job="demo-fastapi-backend"}[5m])))
.
w
EOF

vi -e ${HOME}/sample-app/src/frontend/catalog-info.yaml <<EOF
/kind: Component
/annotations
a
    prometheus.io/rule: >
      (sum(rate(http_requests_total{job="demo-fastapi-frontend",status=~"5..|429"}[5m])))
      /
      (sum(rate(http_requests_total{job="demo-fastapi-frontend"}[5m])))
.
w
EOF
```{{exec}}

</details>
