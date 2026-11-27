![Backstage banner](https://github.com/backstage/backstage/raw/master/docs/assets/headline.png)

Play with Backstage and Argo Workflows. Does not have any tasks or questions. Created to develop scenarios and test things related to the Argo Workflows plugin of Backstage.

The lab initialization takes approximately **5 minutes**. At the end of this process the following components are available:

* **Argo Workflows**, deployed with Helm, with a cron pipeline and a failing workflow in the `demo` namespace.
* **Backstage** (new frontend system) with the `@backstage-community/plugin-argo-workflows` frontend and backend plugins, deployed in the `backstage` namespace with the [Backstage Helm chart](https://github.com/backstage/charts), from the `ghcr.io/testruction/argo-workflows-playground/backstage` image (see `containers/backstage/Dockerfile`).
* A minimal **PostgreSQL** for Backstage, deployed by the Backstage chart, with its data on a volume of the default storage class.
* A `demo-pipeline` catalog component annotated to display its workflows.

Once the initialization completed, click the **Start button**.
