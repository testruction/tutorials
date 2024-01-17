# 13. Add extra labels support to helpers script

The Helpers script `templates/_helpers.tpl` is responsible of the labels allocation like `app.kubernetes.io/name` and `app.kubernetes.io/instance` notably used by the service resource to determine the networking association with the workload pod.

Since the application leverage two components, it is required to add an extra selector label. Either services will randomly send traffic to `backsend` and `frontend` pods.

The [app.kubernetes.io/component](https://kubernetes.io/docs/reference/labels-annotations-taints/#app-kubernetes-io-component) a well known label to such issue.

```bash
yq -i '
.backend.labels = {} |
.backend.selectorLabels.[app.kubernetes.io/component] = "backend" |
.frontend.labels = {} |
.frontend.selectorLabels.[app.kubernetes.io/component] = "frontend"
' chart/values.yaml
```{{exec}}

Update the Helper script to inject the additional labels.

```bash
vi -e chart/templates/_helpers.tpl <<EOF
/define "chart.labels"
a
{{- if .Values.backend.labels }}
{{ toYaml .Values.backend.labels }}
{{- else if .Values.frontend.labels }}
{{ toYaml .Values.frontend.labels }}
{{- end -}}
.
/define "chart.selectorLabels"
/app.kubernetes.io\/instance
a
{{- if .Values.backend.selectorLabels }}
{{ toYaml .Values.backend.selectorLabels }}
{{- else if .Values.frontend.selectorLabels }}
{{ toYaml .Values.frontend.selectorLabels }}
{{- end -}}
.
wq
EOF
```{{exec}}
