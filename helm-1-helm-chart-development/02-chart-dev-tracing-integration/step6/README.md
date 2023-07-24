# Implement backend environment variables

Update the `backend` deployment in order to:

1. Configure OpenTelemetry connectivity to the collector.
3. Dynamically inject environment variables coming from the `env:` and `extraEnv:` configuration sections.

> **Notice**:
> The following command demonstrates how to insert content to an existing file above a specific line.
> * The `/port` position the cursor at the proper line and indentation level
> * The `i` is equivalent to pressing the `i` key to activate the Insert mode (i.e Edit)
> * The `.` is equivalent to pressing the `<Esc>` key to switch back to the Command mode
> * The `wq` is equivalent to typing `:wq` to save the file changes and quit `vi`
>
> Helm variables must be escaped to prevent the shell interpretation (i.e.`\$fullname`, not just `$fullname`).

```yaml
vi -e chart/templates/backend/deployment.yaml <<EOF
/ports
i
          env:
            - name: OTEL_EXPORTER_OTLP_ENDPOINT
              value: http{{ if not .Values.backend.tracing.insecure }}s{{ end }}://{{ default "localhost" (print Chart.Release "-jaeger-collector") }}:4317
            - name: OTEL_EXPORTER_OTLP_INSECURE
              value: {{ .Values.backend.tracing.insecure | quote }}
            {{- with (concat .Values.frontend.env .Values.frontend.extraEnv )}}
              {{- toYaml . | nindent 12 }}
            {{- end }}
.
wq
EOF
```{{exec}}
