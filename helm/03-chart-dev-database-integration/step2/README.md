# Add the database dependency

The application relies on a [Cockroach](https://www.cockroachlabs.com) database instance.

Add a YAML sequence for Cockroach to the chart [dependencies](https://helm.sh/docs/helm/helm_dependency/).

```bash
yq -i '
  .dependencies[1].name = "cockroachdb" |
  .dependencies[1].condition = "cockroachdb.create" |
  .dependencies[1].repository = "https://charts.cockroachdb.com/" |
  .dependencies[1].version = "11.1.5"
' chart/Chart.yaml
```{{exec}}

Update the chart depencencies.

```bash
helm dependency update chart/
```{{exec}}

Add a YAML mapping for the `cockroachdb` configuration values.

> **Notice**:
> The section name [must be same as the dependency name](https://helm.sh/docs/chart_template_guide/subcharts_and_globals/#overriding-values-from-a-parent-chart).

```bash
yq -i '
  .cockroachdb.create = true |
  .cockroachdb.init.provisioning.enabled = true |
  .cockroachdb.tls.enabled=false
' chart/values.yaml
```{{exec}}
