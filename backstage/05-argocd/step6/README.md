# Run the Backstage development server

Before continuing, check that all Kubernetes pods are in **Running** status.

```bash
kubectl get pods --all-namespaces
```{{exec}}

Run the Backstage development server.

```bash
yarn dev
```{{exec}}

> Wait for the message `webpack compiled successfully`.

Use following links to access the different consoles:

Application | URL
--- | ---
Backstage | [Click here]({{TRAFFIC_HOST1_3000}})
Argo CD | [Click here]({{TRAFFIC_HOST1_32080}}) user: **admin**, password: **admin**
Webapp frontend | [Click here]({{TRAFFIC_HOST1_18080}})
Webapp backend | [Click here]({{TRAFFIC_HOST1_18180}}/v1/docs)