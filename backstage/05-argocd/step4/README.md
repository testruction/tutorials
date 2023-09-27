# Add Argo CD plugin configuration

Edit the Argo CD configmap to add a new user for the Backstage application.

```bash
kubectl -n argo-cd edit configmap/argocd-cm -n argo-cd
```{{exec}}

Add the following line in the `data:` mapping.

```yaml
accounts.backstage: apiKey, login
```{{copy}}

Edit the Argo CD RBAC configmap to configure the `backstage` account permissions.

```bash
kubectl -n argo-cd edit configmap/argocd-cm -n argo-cd
```{{exec}}

Add the following line in the `policy.csv:` mapping.

```yaml
g, backstage, role:readonly
```{{copy}}

Generate the API Key for the `backstage` account, then copy the API key from the prompt.

```bash
ARGOCD_AUTH_TOKEN=$(argocd account generate-token --account backstage)
export ARGOCD_AUTH_TOKEN
```{{exec}}

Edit the `backstage-tutorial/app-config.local.yaml` configuration file, the append the following settings to bastage Backstage to query the Prometheus API endpoint.

```yaml
argocd:
  username: admin
  password: admin
  appLocatorMethods:
    - type: 'config'
      instances:
        - name: argocd
          url: http://localhost:10080
          token: ${ARGOCD_AUTH_TOKEN} # Token to use to instance 1
```{{copy}}


<details><summary>Do it for me</summary>

```bash
kubectl -n argo-cd patch configmap/argocd-cm \
--type='json' \
--patch '[{"op": "add", "path": "/data/accounts.backstage", "value": "apiKey,login"}]'

kubectl -n argo-cd patch configmap/argocd-rbac-cm \
--type='json' \
--patch '[{"op": "add", "path": "/data/policy.csv", "value": "g, backstage, role:readonly\n"}]'

ARGOCD_AUTH_TOKEN=$(argocd account generate-token --account backstage)
export ARGOCD_AUTH_TOKEN

yq -i '
  .argocd.username = "admin" |
  .argocd.password = "admin" |
  .argocd.appLocatorMethods[0].type = "config" |
  .argocd.appLocatorMethods[0].instances[0].name = "argocd" |
  .argocd.appLocatorMethods[0].instances[0].url = "http://localhost:10080" |
  .argocd.appLocatorMethods[0].instances[0].token = "${ARGOCD_AUTH_TOKEN}"
' ${HOME}/backstage-tutorial/app-config.local.yaml
```{{exec}}

</details>
