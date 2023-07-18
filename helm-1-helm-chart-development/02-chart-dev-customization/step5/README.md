# Add the database dependency

The application relies on a [Cockroach](https://www.cockroachlabs.com) database instance.

Check the number of resources to be deployed at this stage.

```bash
helm template chart/ | grep 'kind' | wc -l
```{{exec}}

Add Cockroach to the chart [dependencies](https://helm.sh/docs/helm/helm_dependency/).

```bash
yq -i '
  .dependencies[0].name = "cockroachdb" |
  .dependencies[0].condition = "cockroachdb.create" |
  .dependencies[0].repository = "https://charts.cockroachdb.com/" |
  .dependencies[0].version = "11.0.4"
' chart/Chart.yaml
```{{exec}}

Update the chart depencencies.

```bash
helm dependency update chart/
```{{exec}}

Add the `cockroachdb` configuration section and values.

> **Notice**:
> The section name [must be same as the dependency name](https://helm.sh/docs/chart_template_guide/subcharts_and_globals/#overriding-values-from-a-parent-chart).

```bash
yq -i '
  .cockroachdb.create = true |
  .cockroachdb.init.provisioning.enabled = true |
  .cockroachdb.init.provisioning.users[0].name = "demo" |
  .cockroachdb.init.provisioning.users[0].password = "V3ry1ns3cur3P4ssw0rd" |
  .cockroachdb.service.public.type = "LoadBalancer"
' chart/values.yaml
```

Check again the supported number of resources.

```bash
helm template chart/ | grep 'kind' | wc -l
```{{exec}}
