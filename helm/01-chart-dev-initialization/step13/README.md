# 13. Add component labels

Since the application leverage two components, it is required to add an extra selector label in order to avoid the traffic to be randomly sent either `backend` and `frontend` pods.

Edit the both `backend` and `frontend` deployment templates in order to add the well known ["app.kubernetes.io/component"](https://kubernetes.io/docs/reference/labels-annotations-taints/#app-kubernetes-io-component) label to the `templates.metadata.labels` mapping. the edit service templates to add the same lab to the `spec.selector` mapping. 

**Backend**

```bash
vi -e chart/templates/backend/deployment.yaml <<EOF
/spec
/template
/metadata
/labels
a
        app.kubernetes.io/component: backend
.
wq
EOF
```{{exec}}

```bash
vi -e chart/templates/backend/service.yaml <<EOF
/spec
/selector
a
    app.kubernetes.io/component: backend
.
wq
EOF
```{{exec}}

**Frontend**

```bash
vi -e chart/templates/frontend/deployment.yaml <<EOF
/spec
/template
/metadata
/labels
a
        app.kubernetes.io/component: frontend
.
wq
EOF
```{{exec}}

```bash
vi -e chart/templates/frontend/service.yaml <<EOF
/spec
/selector
a
    app.kubernetes.io/component: frontend
.
wq
EOF
```{{exec}}
