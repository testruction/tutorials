# Add the trace collector dependency

Both `backend` and `frontend` components are capable to issue traces in the [OpenTelemetry](https://opentelemetry.io) format.
[Jaeger](https://www.jaegertracing.io) will be used to collect and visualize traces.

Add Jaeger to the chart [dependencies](https://helm.sh/docs/helm/helm_dependency/).

```bash
yq -i '
  .dependencies[1].name = "jaeger" |
  .dependencies[1].condition = "jaeger.create" |
  .dependencies[1].repository = "https://jaegertracing.github.io/helm-charts/" |
  .dependencies[1].version = "0.71.10"
' chart/Chart.yaml
```{{exec}}

Update the chart depencencies.

```bash
helm dependency update chart/
```{{exec}}

Add the `jaeger` configuration section and values.

```bash
yq -i '
  .jaeger.create = false |
  .jaeger.allInOne.enabled = true
' chart/values.yaml
```{{exec}}

Check the supported number of resources with Jaeger enabled.

```bash
helm template --set jaeger.create=true chart/ | grep 'kind' | wc -l
```{{exec}}
