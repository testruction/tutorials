# Add the sample application to the catalog

Edit the `backstage-tutorial/app-config.local.yaml` configuration and add the following content to register the example application entities.

```yaml
catalog:
  locations:
    - type: file
      target: ../../../web-app/catalog-info.yaml
```{{copy}}

> **Notice**:
> The path to the catalog is relative to the `packages/backend` directory.

<details><summary>Do it for me</summary>

```bash
yq -i '
  .catalog.locations[0].type = "file" |
  .catalog.locations[0].target = "../../../web-app/catalog-info.yaml"
' app-config.local.yaml
```{{exec}}

</details>
