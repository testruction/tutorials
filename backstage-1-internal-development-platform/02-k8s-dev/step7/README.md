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

> [Click here]({{TRAFFIC_HOST1_3000}}) to open the Web console.
