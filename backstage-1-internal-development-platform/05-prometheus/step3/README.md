# Run the Backstage development server

Start the Kubernetes client proxy to allow the Backstage to access the cluster API server.

```bash
kubectl proxy &
```{{exec}}

> Press **CTRL+C**  to let kubectl proxy running in the background.

Run the Backstage development server.

```bash
yarn dev
```{{exec}}

> Wait for the message `webpack compiled successfully`.
> Use following links to access:
> * [Click here]({{TRAFFIC_HOST1_3000}}) for Backstage application.
> * [Click here]({{TRAFFIC_HOST1_9090}}) for Prometheus.
> * [Click here]({{TRAFFIC_HOST1_28081}}) for Sample App API doc.