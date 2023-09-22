# Deploy the sample application

> **Warning**:
> Before continuing, purge the Docker environment to recover some free disk-space.
> Run: `docker system prune -af --volumes`{{exec}}

> Click on the **Tab1** before continuing.

Deploy the application to the Kubernetes Cluster.

```bash
# Update Helm chart dependencies
helm dependency update ./web-app/chart/

# Deploys the sample application
helm install --create-namespace --namespace fastapi-demo \
--set cockroachdb.statefulset.replicas="1" \
--set cockroachdb.service.public.type="LoadBalancer" \
--set cockroachdb.storage.persistentVolume.size="1Gi" \
demo ./web-app/chart/
```{{exec}}

Register the sample application component in Backstage.

* [Click here]({{TRAFFIC_HOST1_7007}}) to open the Web console.
* Click on the **CREATE** button.
* Click on the **REGISTER EXISTING COMPONENT** button.
* Use the following URL `https://github.com/testruction/fastapi-sqlalchemy-cockroachdb/blob/main/catalog-info.yaml`

Once registered, navigate in the **Component** related pages to find the associated kubernetes resources discovered.