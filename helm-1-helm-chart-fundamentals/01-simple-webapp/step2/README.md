# Create initial chart

Create a `chart` directory at the root of the source code repository, using the default structure included in the `helm` command line tool.

```bash
helm create ./chart
```{{exec}}

This command populates the `chart/` directory with following files.

```bash
chart/
|-- charts  # Dependant charts
|-- templates
|   |-- tests
|       |-- test-connection.yaml # Test running after the deployments
|   |-- NOTES.txt
|   |-- _helpers.tpl  # Initialize variables and common YAML constructs (e.g Labels)
|   |-- deployment.yaml # Service deployment
|   |-- hpa.yaml  # Autoscaling of the amount of replicas deployed
|   |-- ingress.yaml  # Endpoint to expose the service outside of the cluster
|   |-- service.yaml  # Endpoint to expose the service inside the cluster
|   |-- serviceaccount.yaml  # Service account used interact with the Kubernetes API
|-- Chart.yaml  # Chart artifact specifications
|-- values.yaml # Deployment configuration data
```
