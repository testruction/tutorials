# Implement frontend environment variables

Update the `frontend` deployment in order to:

1. Configure OpenTelemetry connectivity to the collector.
2. Configure the `BACKEND_URL` variable  required to establish communication to the `backend` ReSTful API.
3. Dynamically inject environment variables coming from the `env:` and `extraEnv:` configuration sections.


```yaml
vi -e chart/templates/frontend/deployment.yaml <<EOF
/ports
i
          env:
            - name: OTEL_EXPORTER_OTLP_ENDPOINT
              value: http{{ if not .Values.frontend.tracing.insecure }}s{{ end }}://{{ default "localhost" (print Chart.Release "-jaeger-collector") }}:4317
            - name: OTEL_EXPORTER_OTLP_INSECURE
              value: {{ .Values.frontend.tracing.insecure | quote }}
            - name: BACKEND_API_URL
              {{- \$fullName := include "chart.fullname" . }}
              value: {{ print "http://" \$fullName "-backend:" .Values.backend.service.port | quote }}
            {{- with (concat .Values.frontend.env .Values.frontend.extraEnv )}}
              {{- toYaml . | nindent 12 }}
            {{- end }}
.
wq
EOF
```{{exec}}
