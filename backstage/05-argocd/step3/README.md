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
argocd account generate-token --account backstage
```{{exec}}

Edit the `backstage-tutorial/app-config.local.yaml` configuration file, the append the following settings to bastage Backstage to query the Prometheus API endpoint.

```yaml
proxy:
  '/argocd0/api':
    target: http://localhost:10080/api/v1/
    changeOrigin: true
    # only if your argocd api has self-signed cert
    secure: false
    headers:
      Cookie:
        $env: ARGOCD_AUTH_TOKEN_HERE
```{{copy}}

> **Notice**:
> Don't forget to replate the ARGOCD_AUTH_TOKEN_HERE by the API key generated previously

<details><summary>Do it for me</summary>

```bash
kubectl -n argo-cd patch configmap/argocd-cm \
--type='json' \
--patch '[{"op": "add", "path": "/data/accounts.backstage", "value": "apiKey,login"}]'

kubectl -n argo-cd patch configmap/argocd-rbac-cm \
--type='json' \
--patch '[{"op": "add", "path": "/data/policy.csv", "value": "g, backstage, role:readonly\"\n"}]'

ARGOCD_AUTH_TOKEN=$(argocd account generate-token --account backstage)
export ARGOCD_AUTH_TOKEN

yq -i '
  .proxy.'/argocd0/api'.target = "http://localhost:10080/api/v1/" |
  .proxy.'/argocd0/api'.changeOrigin = true |
  .proxy.'/argocd0/api'.secure = false |
  .proxy.'/argocd0/api'.headers.Cookie.$env = "ARGOCD_AUTH_TOKEN"
' ${HOME}/backstage-tutorial/app-config.local.yaml
```{{exec}}

</details>
