# Allocate distinct container images

Update the Open Container Image (OCI) repository of the `backend` and `frontend` services.

* **backend**: `ghcr.io/testruction/fastapi-sqlalchemy-cockroachdb/backend`
* **frontend**: `ghcr.io/testruction/fastapi-sqlalchemy-cockroachdb/frontend`

**Backend**:

```bash
yq -i '.backend.image.repository = "ghcr.io/testruction/fastapi-sqlalchemy-cockroachdb/backend"' chart/values.yaml
```{{exec}}

**Frontend**:

```bash
yq -i '.frontend.image.repository = "ghcr.io/testruction/fastapi-sqlalchemy-cockroachdb/frontend"' chart/values.yaml
```{{exec}}

Add configuration values to control the deployment of the `backend` and `frontend` services.

> **Notice**: The following command demonstrates how to address mappings at once using `yq`.

```bash
yq -i '.backend.enabled = true | .frontend.enabled = true' chart/valutes.yaml
```{{exec}}
