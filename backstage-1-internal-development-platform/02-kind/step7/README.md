# Deploy Backstage in the Kubernetes cluster

Create the Namespace dedicated to the Backstage application.

```bash
kubectl apply -f /root/namespace.yaml
```

Deploy the PostgreSQL database.

```bash
kubectl apply -f /root/postgres.yaml
```

Deploy the Bastage application.

```bash
kubectl apply -f /root/backstage.yaml
```

[Click here]({{TRAFFIC_HOST1_3000}})  to open the Web console.