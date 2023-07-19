# Add environment variables

Environment variables are commonly to leverage the configuration enabling the communication between application components.

## Backend

Add database connection configuration values.
If `cockroachdb.provision = true`; the default; then those values will be ignored.

```bash
yq -i '
  .backend.database.cockroachdb.host = null |
  .backend.database.cockroachdb.port = 26257 |
  .backend.database.cockroachdb.username = "root" |
  .backend.database.cockroachdb.password = "password" |
  .backend.database.cockroachdb.database = null
' chart/values.yaml
```

Create the secret template to be associated to the `backend` deployment.

> **Notice**:
> If the chart provision the instance, as well as the users. Then the first defined user will be used.
> If the chart provision the instance, but not users. Then the default Cockroach credentials specified in the `backend` section will be used.
> If the chart does provision the instance (i.e `cockroach.provision: false`), then credentials specified in the `backend` section will be used.

```yaml
cat <<EOF | tee chart/templates/backend/secret.yaml
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "chart.fullname" . }}-backend
  labels:
    {{- include "chart.labels" . | nindent 4 }}
type: Opaque
data:
  {{- if and (eq .Values.cockroachdb.provision true) (eq .Values.cockroachdb.init.provisioning.enabled true) }}
  {{- with (first .Values.cockroachdb.init.provisioning.users) }}
  username: {{ .name | b64enc | quote }}
  password: {{ .password | b64enc | quote }}
  {{- end }}
  {{- else }}
  username: {{ .Values.backend.database.cockroachdb.username | b64enc | quote }}
  password: {{ .Values.backend.database.cockroachdb.password | b64enc | quote }}
  {{- end }}
EOF
```

Test the condition where users provisionning is disabled so the default `password` password is rendered.

```bash
helm template --set cockroachdb.init.provisioning.enabled=false chart/ \
| grep -E '\s{2}\password:' \
| cut -d '"' -f 2 \
| base64 -d
```
