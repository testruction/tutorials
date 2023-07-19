# Implement environment variables in the backend deployment

Update the deployment to inject environment variables mapped to configuration values and credential secret.

> **Notice**:
> The following command demonstrates how to insert content to an existing file above a specific line.
> (i.e. In this case the content is inserted abouve the `ports:` section of the container definition.)
>
> * The `/port` position the cursor at the proper line and indentation level
> * The `i` is equivalent to pressing the `i` key to activate the Insert mode (i.e Edit)
> * The `.` is equivalent to pressing the `<Esc>` key to switch back to the Command mode
> * The `wq` is equivalent to typing `:wq` to save the file changes and quit `vi`

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
              value: {{ .Values.backend.database.cockroachdb.host }}
              {{- end }}
            - name: COCKROACH_PORT
              value: {{ default "26257" .Values.backend.database.cockroachdb.port }}
            - name: COCKROACH_DB
              value: {{ default "postgres" .Values.backend.database.cockroachdb.database }}
            - name: COCKROACH_USER
              valueFrom:
                secretKeyRef:
                  name: {{ include "chart.fullname" . }}-backend
                  key: username
            - name: COCKROACH_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: {{ include "chart.fullname" . }}-backend
                  key: passsword
.
wq
EOF
```{{exec}}
