# 3. Create and populate component directories

Create distinct template directories for `backend` and `frontend` services.

```bash
mkdir -p chart/templates/backend chart/templates/frontend
```{{exec}}

Copy the templates YAML files to each service dedicated folder.

**Backend**:

```bash
cp chart/templates/*.yaml chart/templates/backend/
```{{exec}}

**Frontend**:

```bash
cp chart/templates/*.yaml chart/templates/frontend/
```{{exec}}

Cleanup templates located default templates YAML files.

```bash
rm -vf chart/templates/*.yaml
```{{exec}}
