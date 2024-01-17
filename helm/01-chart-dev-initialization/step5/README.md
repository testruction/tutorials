# 5. Add conditions to control the deployment

When a chart supports the deployment of multiple components it is a good practice to add a condition to control the deployment of each components.

> **Notice**:
> [`yq`](https://mikefarah.gitbook.io/yq/) is a multi-platform command line tool dedicated to the querying of YAML file.
> It also support other data serializtion format like XML, TOML or json.
> The `-i (--inplace)` applies requested changes directly to to the file.

Add a condition to both `backend` and `frontend`.

**Backend**:

```bash
yq -i '.backend.enabled = true' chart/values.yaml
```{{exec}}

**Frontend**:

```bash
yq -i '.frontend.enabled = true' chart/values.yaml
```{{exec}}
