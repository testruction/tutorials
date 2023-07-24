# Configure backend and frontend environment variables

Add environment variables to configure the connectivity to Jaeger using the OpenTelemetry protocol.

```bash
yq -i '
  .jaeger.extraEnv[0].name = "COLLECTOR_OTLP_ENABLED" |
  .jaeger.extraEnv[0].value = true |
  .backend.env[0].name = "OTEL_RESOURCE_ATTRIBUTES" |
  .backend.env[0].value = "ervice.namespace=io.testruction,service.name=backendservice" |
  .frontend.env[0].name = "OTEL_RESOURCE_ATTRIBUTES" |
  .frontend.env[0].value = "ervice.namespace=io.testruction,service.name=frontendservice"
' chart/values.yaml
```{{exec}}

Add variables to enable customization of the trace collector address if Jager dependency is disables (i.e. `jaeger.enabled: false`).

```bash
yq -i '
  .backend.tracing.url = null |
  .backend.tracing.insecure = true |
  .frontend.tracing.url = null |
  .frontend.tracing.insecure = true
' chart/values.yaml
```{{exec}}