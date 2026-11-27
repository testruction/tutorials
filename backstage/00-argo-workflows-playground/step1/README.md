# Environment

Backstage runs in the `backstage` namespace.

```bash
kubectl -n backstage get pods,services
```{{exec}}

Application | URL
--- | ---
Backstage | [Click here]({{TRAFFIC_HOST1_7007}}) (sign in as **guest**)
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
> The plugin needs the `argoworkflows.argoproj.io/workflow-selector` and `backstage.io/kubernetes-namespace` annotations on the entity (see `~/deploy/backstage/catalog-info.yaml`), and an `argoWorkflows` instance in the configuration of Backstage. The image reads the URL and the service account token of the `backstage` account (created in the `argo` namespace) from the `ARGO_WORKFLOWS_URL` and `ARGO_WORKFLOWS_TOKEN` variables.
