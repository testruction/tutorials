# Deploy the sample application

Deploy the application to the Kubernetes Cluster.

```bash
# Move to the sample application
cd ~/sample-app

# Update Helm chart dependencies
helm dependency update chart/

# Deploys the sample application
helm install --create-namespace --namespace fastapi-demo \
--set "cockroachdb.statefulset.replicas=1" \
--set "cockroachdb.storage.persistentVolume.size=1Gi" \
demo chart/
```{{exec}}

Register the sample application component in Backstage.

* [Click here]({{TRAFFIC_HOST1_8008}}) to open the Web console.
* Click on the **CREATE** button.
* Click on the **REGISTER EXISTING COMPONENT** button.
* Use the following URL `https://github.com/testruction/fastapi-sqlalchemy-cockroachdb/blob/main/catalog-info.yaml`
