# Add Prometheus rules to components

Edit the `web-app/src/backend/catalog-info.yaml`, then add the following annotation.

```yaml
metadata:
  annotations:
    argocd/app-name: demo
```

Edit the `web-app/src/frontend/catalog-info.yaml`, then add the following annotation.

```yaml
metadata:
  annotations:
    argocd/app-name: demo
```

<details><summary>Do it for me</summary>

```bash
vi -e ${HOME}/web-app/src/backend/catalog-info.yaml <<EOF
/kind: Component
/annotations
a
    argocd/app-name: demo
.
w
EOF

vi -e ${HOME}/web-app/src/frontend/catalog-info.yaml <<EOF
/kind: Component
/annotations
a
    argocd/app-name: demo
.
w
EOF
```{{exec}}

</details>
