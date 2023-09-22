# Run the Backstage development server

Before continuing, check that all Kubernetes Pods are in "Ready" status.

```bash
kubectl get pods --all-namespaces
```{{exec}}

Run the Backstage development server.

```bash
yarn dev
```{{exec}}

> Wait for the message `webpack compiled successfully`.

Use following links to access the different consoles:

* Backstage application [Click here]({{TRAFFIC_HOST1_3000}}) .
* Prometheus [Click here]({{TRAFFIC_HOST1_9090}}).
* Sample App API doc [Click here]({{TRAFFIC_HOST1_18180}}/v1/docs).
