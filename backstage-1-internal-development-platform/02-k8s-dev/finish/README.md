# Deploy the sample application

> **Warning**:
> Before continuing, purge the Docker environment to recover some free disk-space.
> Run: `docker system prune -af --volumes`{{exec}}

Deploy the application to the Kubernetes Cluster.

```bash
# Update Helm chart dependencies
helm dependency update ../sample-app/chart/

# Deploys the sample application
helm install --create-namespace --namespace fastapi-demo \
--set "cockroachdb.statefulset.replicas=1" \
--set cockroachdb.service.public.type="LoadBalancer" \
--set "cockroachdb.storage.persistentVolume.size=1Gi" \
demo ../sample-app/chart/
```{{exec}}

Register the sample application component in Backstage.

* [Click here]({{TRAFFIC_HOST1_3000}}) to open the Web console.
* Navigate to the **frontend** component, then click on the **Kubernetes** tab.

The frontend is in `CrashLoopBackOff` because the database is not populated.

Run the following command to initialize the database.

```bash
populatedb.sh
```

Then return the Console to check the pod status.
