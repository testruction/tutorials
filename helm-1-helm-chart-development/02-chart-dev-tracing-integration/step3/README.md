# Add the tracing dependency

The application relies on a [Jaeger](https://www.jaegertracing.io) trace collector and visualizer.

Add a YAML sequence for Jaeger to the chart [dependencies](https://helm.sh/docs/helm/helm_dependency/).

```bash
yq -i '
  .dependencies[0].name = "jaeger" |
  .dependencies[0].condition = "jaeger.enabled" |
  .dependencies[0].repository = "https://jaegertracing.github.io/helm-charts" |
  .dependencies[0].version = "0.71.10"
' chart/Chart.yaml
```{{exec}}

Update the chart depencencies.

```bash
helm dependency update chart/
```{{exec}}
