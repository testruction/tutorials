# Deploy the sample application

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

* [Click here]({{TRAFFIC_HOST1_3000}}) to open the Web console.
* Navigate to the **frontend** component, then click on the **Kubernetes** tab.

The frontend is in `CrashLoopBackOff` because the database is not populated. ([Click here]({{TRAFFIC_HOST1_8080}}/#/database/postgres)).

Run the following command to initialize the database.

```bash
populatedb.sh
```{{exec}}

Then return the Backstage console to check the pod status.
