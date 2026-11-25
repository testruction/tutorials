# Write the documentation of a component

TechDocs looks for the `backstage.io/techdocs-ref` annotation on a catalog entity. The value `dir:.` means that the documentation sources are stored in the same directory as the `catalog-info.yaml` file.

Create a sample component with its documentation.

```bash
mkdir -p examples/techdocs-demo/docs

cat > examples/techdocs-demo/catalog-info.yaml <<'CATALOG'
apiVersion: backstage.io/v1alpha1
kind: Component
metadata:
  name: techdocs-demo
  description: A component documented with TechDocs.
  annotations:
    backstage.io/techdocs-ref: dir:.
spec:
  type: service
  lifecycle: experimental
  owner: guests
CATALOG

cat > examples/techdocs-demo/mkdocs.yml <<'MKDOCS'
site_name: TechDocs demo
nav:
  - Home: index.md
  - Getting started: getting-started.md
plugins:
  - techdocs-core
MKDOCS

cat > examples/techdocs-demo/docs/index.md <<'INDEX'
# TechDocs demo

This documentation is written in Markdown and stored next to the source code.

!!! tip
    TechDocs supports the admonitions of Material for MkDocs.
INDEX

cat > examples/techdocs-demo/docs/getting-started.md <<'START'
# Getting started

1. Edit the Markdown files in the `docs/` directory.
2. Update the `nav` section of `mkdocs.yml`.
3. Refresh the **Docs** tab of the component in Backstage.
START
```{{exec}}

Register the component in the software catalog, by adding a `file` location to the `app-config.local.yaml` file.

```bash
yq -i '
  .catalog.locations[0].type = "file" |
  .catalog.locations[0].target = "../../examples/techdocs-demo/catalog-info.yaml"
' ./app-config.local.yaml
```{{exec}}

> **Notice**:
> The path of a `file` location is relative to the `packages/backend` directory.
>
> The `catalog.locations` list of the local file replaces the one of `app-config.yaml`, so the example entities of the template are not loaded.
