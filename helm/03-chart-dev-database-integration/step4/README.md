# Integrate backend environment variables

Update the deployment to inject environment variables mapped to configuration values and credential secret.

Update the `backend` deployment in order to:

1. Configure non-confidential variables required to establish communication to the database.
2. Retrieve credentials to connect to the database for the secret.
3. Dynamically inject environment variables coming from the `env:` and `extraEnv:` configuration sections.

```yaml
vi -e chart/templates/backend/deployment.yaml <<EOF
/ports
i
            - name: COCKROACH_HOST
              {{- if .Values.cockroachdb.create }}
              value: {{ print .Release.Name "-cockroachdb-public" | quote }}
              {{- else if eq "" .Values.backend.database.cockroachdb.host }}
              {{ fail "backend.database.cockroachdb.host can't be empty if cockroachdb.create is set to false"}}
              value: {{ .Values.backend.database.cockroachdb.host | quote }}
              {{- end }}
            - name: COCKROACH_PORT
              value: {{ default "26257" .Values.backend.database.cockroachdb.port | quote }}
            - name: COCKROACH_DB
              value: {{ default "postgres" .Values.backend.database.cockroachdb.database | quote }}
            - name: COCKROACH_USER
              valueFrom:
                secretKeyRef:
                  name: {{ include "chart.fullname" . }}-backend
                  key: username
            - name: COCKROACH_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: {{ include "chart.fullname" . }}-backend
                  key: password
.
wq
EOF
```{{exec}}
