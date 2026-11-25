# Configure TechDocs

Review the default TechDocs configuration.

```bash
yq '.techdocs' app-config.yaml
```{{exec}}

By default the generator runs MkDocs in a Docker container (`runIn: docker`). In this lab MkDocs is installed on the host, so the generator is set to run it locally.

Setting | Value | Description
--- | --- | ---
`techdocs.builder` | `local` | The Backstage backend builds the docs on demand
`techdocs.generator.runIn` | `local` | Use the `mkdocs` command of the host
`techdocs.publisher.type` | `local` | Store the generated site on the backend local disk

Check that `mkdocs` is available.

```bash
source ~/.bashrc
mkdocs --version
```{{exec}}

Create the `app-config.local.yaml` file that overrides the default `app-config.yaml`, to use the local generator and to allow external access from KillerCoda.

```bash
# Retrieve the KillerCoda instance URL
export KC_FRONTEND_URL=$(sed -e 's/PORT/3000/' -e 's/https/http/' /etc/killercoda/host)
export KC_BACKEND_URL=$(sed 's/PORT/7007/' /etc/killercoda/host)

yq -i '
  .techdocs.builder = "local" |
  .techdocs.generator.runIn = "local" |
  .techdocs.publisher.type = "local" |
  .app.listen.host = "0.0.0.0" |
  .app.listen.port = 3000 |
  .app.baseUrl = strenv(KC_FRONTEND_URL) |
  .backend.listen.host = "0.0.0.0" |
  .backend.listen.port = 7007 |
  .backend.baseUrl = strenv(KC_BACKEND_URL) |
  .backend.cors.origin = strenv(KC_FRONTEND_URL)
' ./app-config.local.yaml
```{{exec}}
