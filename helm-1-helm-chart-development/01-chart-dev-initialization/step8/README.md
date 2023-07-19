# Allocate distinctt container images

Update the Open Container Image (OCI) repository of the `backend` and `frontend` services.

* **backend**: `testruction/fastapi-sqlalchemy-cockroachdb/backend`
* **frontend**: `testruction/fastapi-sqlalchemy-cockroachdb/frontend`

**Backend**:

```bash
yq -i '.backend.image.repository = "ghcr.io/testruction/fastapi-sqlalchemy-cockroachdb/backend"' chart/values.yaml
```{{exec}}

**Frontend**:

```bash
yq -i '.frontend.image.repository = "ghcr.io/testruction/fastapi-sqlalchemy-cockroachdb/frontend"' chart/values.yaml
```{{exec}}
