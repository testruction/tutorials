# Implement environment variables in the backend deployment

Update the deployment to inject environment variables mapped to configuration values and credential secret.

```yaml
vi -e chart/templates/backend/deployment.yaml <<EOF
/ports
i
          env:
            - name: COCKROACH_HOST
              {{- if .Values.cockroachdb.provision }}
              value: {{ .Release.Name }}-cockroachdb-public
              {{- else if eq "" .Values.backend.database.cockroachdb.host }}
              {{ fail "backend.database.cockroachdb.host can't be empty if cockroachdb.provision is set to false"}}
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
