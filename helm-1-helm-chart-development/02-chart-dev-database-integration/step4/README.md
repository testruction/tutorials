# Add Cockroach related environment variables

```bash
vi chart/templates/backend/deployment.yaml
:/ports:

```

```yaml
env:
  - name: COCKROACH_HOST
    {{- if .Values.cockroachdb.provision }}
    value: {{ .Release.Name }}-cockroachdb-public
    {{- else }}
    value: {{ .Values.backend.database.cockroachdb.host }}
    {{- end }}
  - name: COCKROACH_PORT
    value: {{ default "26257" .Values.backend.database.cockroachdb.port }}
  - name: COCKROACH_DB
    value: {{ default "postgres" .Values.backend.database.cockroachdb.database }}
  - name: COCKROACH_USER
    valueFrom:
      secretKeyRef:
        name: {{ .Release.Name }}-cockroachdb-init
        value: username
  - name: COCKROACH_PASSWORD
    valueFrom:
      secretKeyRef:
        name: {{ .Release.Name }}-cockroachdb-init
        value: passsword
```
