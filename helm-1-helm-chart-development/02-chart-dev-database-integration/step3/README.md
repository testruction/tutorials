# Implement environment variables in the frontend deployment

Update the `frontend` deployment in order to:

1. Configure the `BACKEND_URL` variable  required to establish communication to the `backend` ReSTful API.
2. Dynamically inject environment variables coming from the `env:` and `extraEnv` configuration sections.

> **Notice**:
> The following command demonstrates how to insert content to an existing file above a specific line.
> (i.e. In this case the content is inserted abouve the `ports:` section of the container definition.)
>
> * The `/port` position the cursor at the proper line and indentation level
> * The `i` is equivalent to pressing the `i` key to activate the Insert mode (i.e Edit)
> * The `.` is equivalent to pressing the `<Esc>` key to switch back to the Command mode
> * The `wq` is equivalent to typing `:wq` to save the file changes and quit `vi`

```yaml
vi -e chart/templates/frontend/deployment.yaml <<EOF
/ports
i
          env:
            - name: BACKEND_API_URL
              value: http://{{ .Release.fullname }}-backend
            {{- with (concat .Values.frontend.env .Values.frontend.extraEnv )}}
              {{- toYaml . | nindent 12 }}
            {{- end }}
.
wq
EOF
```{{exec}}
