# Add Prometheus rules to components

Edit the `sample-app/src/backend/catalog-info.yaml`, then add the following annotation.

```yaml
metadata:
  annotions:
    prometheus.io/rule: >-
      sum by (service)(rate(http_requests_total{status=~"5..|4.."}[5m]))
```

Edit the `sample-app/src/frontend/catalog-info.yaml`, then add the following annotation.

```yml
metadata:
  annotions:
    prometheus.io/rule: >-
      sum(rate(http_requests_total{status=~"5..|4.."}[5m]))
```

<details><summary>Do it for me</summary>

```bash
vi -e ${HOME}/sample-app/src/backend/catalog-info.yaml <<EOF
/kind: Component
/annotations
a
    prometheus.io/rule: >-
      sum by (service)(rate(http_requests_total{status=~"5..|4.."}[5m]))
.
w
EOF

vi -e ${HOME}/sample-app/src/frontend/catalog-info.yaml <<EOF
/kind: Component
/annotations
a
    prometheus.io/rule: >-
      sum(rate(http_requests_total{status=~"5..|4.."}[5m]))
.
w
EOF
```{{exec}}

</details>
