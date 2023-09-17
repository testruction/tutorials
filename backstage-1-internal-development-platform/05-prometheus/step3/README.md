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

Use following links to access the different consoles:

* Backstage application [Click here]({{TRAFFIC_HOST1_3000}}) .
* Prometheus [Click here]({{TRAFFIC_HOST1_9090}}).
* Sample App API doc [Click here]({{TRAFFIC_HOST1_28081}}).
