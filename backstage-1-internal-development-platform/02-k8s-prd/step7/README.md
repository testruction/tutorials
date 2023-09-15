# Deploy Backstage in the Kubernetes cluster

Edit the `backstage.yaml` and replace the **GITHUB_TOKEN** by a [Backstage complient Github Classic token](https://backstage.io/docs/integrations/github/locations#token-scopes) encoded in Base64.

> i.e.`printf "ghp_***" | base64`

Create the Namespace dedicated to the Backstage application deployment.

```bash
kubectl apply -f /root/namespace.yaml
```{{exec}}

Deploy the PostgreSQL database.

```bash
kubectl apply -f /root/postgres.yaml
```{{exec}}

Deploy the Bastage application.

```bash
kubectl apply -f /root/backstage.yaml
```{{exec}}

Check the provisionned resources.

```bash
kubectl -n backstage get pod,svc,deploy,secret,pvc,pv
```{{exec}}

> [Click here]({{TRAFFIC_HOST1_7007}}) to open the Web console.
