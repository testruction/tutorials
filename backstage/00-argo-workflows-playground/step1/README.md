# Environment

Run the Backstage application in development mode.

```bash
cd ~/backstage-tutorial
yarn start
```{{exec}}

> Wait for the message `webpack compiled successfully`.

Application | URL
--- | ---
Backstage | [Click here]({{TRAFFIC_HOST1_3000}}) (sign in as **guest**)
Argo Workflows | [Click here]({{TRAFFIC_HOST1_2746}})

1. In Backstage, open the **demo-pipeline** component from the catalog.
2. Click on the **Argo Workflows** tab: the runs of the workflows labeled `app=demo` are listed. Click on a row to display its DAG.
3. Compare with the Argo Workflows console and with the command line.

Open a second terminal tab to watch the workflows.

```bash
kubectl -n demo get workflows --watch
```{{exec}}

Start another run of the failing workflow.

```bash
kubectl create -f ~/deploy/argo-workflows/failing-workflow.yaml
```{{exec}}

> **Notice**:
> The plugin only needs two things on the entity: the `argoworkflows.argoproj.io/workflow-selector` annotation (see `~/deploy/backstage/catalog-info.yaml`) and an `argoWorkflows` instance in the `app-config.local.yaml` file of the application. The instance holds the URL and the service account token of the `backstage` account created in the `argo` namespace.
