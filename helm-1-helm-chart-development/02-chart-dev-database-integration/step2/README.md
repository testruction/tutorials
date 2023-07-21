# Frontend environment variables

Add the backend `BACKEND_URL` environment varaibles  to establish communications with the ReSTful API handle by `backend`.

A good practice is to implement two level of environment support to support scenarios listed below:

Section | Description
--- | ---
**`env: []`** | Well-known variables supported by the application
**`extraEnv: []`** | Temporary variables (i.e test, debug, etc.)

Add the environment variables support to the `frontend` component.

```bash
yq -i '
  .frontend.env[0].name = "BACKEND_API_URL" |
  .frontend.env[0].value = "http://backend:8000" |
  .frontend.extraEnv = []
' chart/values.yaml
```{{exec}}

Update `frontend`the deployment to inject both environment variables specified in the `env:` and `extraEnv` configuration sections.

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
          {{- with (concat .Values.frontend.env .Values.frontend.extraEnv )}}
            {{- toYaml . | nindent 12 }}
          {{- end }}
.
wq
EOF
```{{exec}}

<details><summary>Manual way</summary>

```yaml
env:
{{- with (concat .Values.frontend.env .Values.frontend.extraEnv )}}
  {{- toYaml . | nindent 8 }}
{{- end }}
```

</details>