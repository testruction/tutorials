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
    prometheus.io/rule: >-
      (sum(rate(http_requests_total{job="demo-fastapi-backend"\,status=~"5..|429"}[5m])))
      /
      (sum(rate(http_requests_total{job="demo-fastapi-backend"}[5m])))
.
w
EOF

vi -e ${HOME}/sample-app/src/frontend/catalog-info.yaml <<EOF
/kind: Component
/annotations
a
    prometheus.io/rule: >-
      (sum(rate(http_requests_total{job="demo-fastapi-frontend",status=~"5..|429"}[5m])))
      /
      (sum(rate(http_requests_total{job="demo-fastapi-frontend"}[5m])))
.
w
EOF
```{{exec}}

</details>


(sum(rate(http_requests_total{job="demo-fastapi-frontend",status=~"5..|429"}[5m])))/(sum(rate(http_requests_total{job="demo-fastapi-frontend"}[5m])))


https://60786cca-4710-40ec-bb09-2ae7d6d9ab0f-10-244-8-142-7007.saci.r.killercoda.com/api/proxy/prometheus0/api/query_range?query=(sum(rate(http_requests_total%7Bjob=%22demo-fastapi-backend%22&start=1695155471.126&end=1695159071.126&step=14