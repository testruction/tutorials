# Add the Jaeger deployment configuration

Add a YAML mapping for the `jaeger` configuration values.

> **Notice**:
> The section name [must be same as the dependency name](https://helm.sh/docs/chart_template_guide/subcharts_and_globals/#overriding-values-from-a-parent-chart).

```bash
yq -i '
  .jaeger.enabled = true |
  .jaeger.allInOne.enabled = true |
  .jaeger.ingester.enabled = false |
  .jaeger.agent.enabled = false |
  .jaeger.collector.enabled = false |
  .jaeger.query.enabled = false |
  .jaeger.spark.enabled = false |
  .jaeger.hotrod.enabled = false
' chart/values.yaml
```{{exec}}

Check again the supported number of resources.

```bash
helm template chart/ | grep 'kind' | wc -l
```{{exec}}

> The number of resource should have increased.