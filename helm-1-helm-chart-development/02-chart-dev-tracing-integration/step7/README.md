# Integrate frontend environment variables

Update the `frontend` deployment in order to:

1. Configure OpenTelemetry connectivity to the collector.
2. Configure the `BACKEND_URL` variable  required to establish communication to the `backend` ReSTful API.
3. Dynamically inject environment variables coming from the `env:` and `extraEnv` configuration sections.

> **Notice**:
> Helm variables must be escaped to prevent the shell interpretation (i.e.`\$fullname`, not just `$fullname`).

```yaml
vi -e chart/templates/frontend/deployment.yaml <<EOF
/ports
i
          env:
            {{- \$fullName := include "chart.fullname" . }}
            - name: OTEL_EXPORTER_OTLP_ENDPOINT
              value: http{{ if not .Values.frontend.jaeger.insecure }}s{{ end }}://{{ default localhost (print \$fullName "-collector") }}:4317
            - name: OTEL_EXPORTER_OTLP_INSECURE
              value: {{ .Values.frontend.tracing.insecure }}
            - name: BACKEND_API_URL
              value: {{ print "http://" \$fullName "-backend:" .Values.backend.service.port | quote }}
            {{- with (concat .Values.frontend.env .Values.frontend.extraEnv )}}
              {{- toYaml . | nindent 12 }}
            {{- end }}
.
wq
EOF
```{{exec}}
