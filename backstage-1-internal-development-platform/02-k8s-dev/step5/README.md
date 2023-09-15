# Enable external access

In developmenet, the Backstage **frontend** and **backend** components listens only on the `localhost (127.0.0.1)` interface , respectively on ports **3000/tcp** and **7007/tcp**.

In order to enable external access in development mode, settings must be added to the `app-config.local.yaml` file which overrides the default `app-config.yaml`.

Copy the entire URL from this file then edit the `app-config.local.yaml` configuration file.
Add the following content while ensuring to change the **PORT** section of the URL by **3000** for the frontend and **7000** for the fontend component.

```yaml
app:
  baseUrl: http://xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx-x-x-x-x-3000.saci.r.killercoda.com
  listen:
    host: 0.0.0.0
    port: 3000

backend:
  baseUrl: https://xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx-x-x-x-x-7007.saci.r.killercoda.com
  listen:
    host: 0.0.0.0
    port: 7007
  cors:
    origin: http://xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx-x-x-x-x-3000.saci.r.killercoda.com
```

<details><summary>Dot it for me</summary>

```bash
# Retreive the KillerCoda instance URL
export KC_FRONTEND_URL=$(cat /etc/killercoda/host | sed -e 's/PORT/3000/' -e 's/https/http/')
export KC_BACKEND_URL=$(cat /etc/killercoda/host | sed 's/PORT/7007/')

yq -i '
  .app.listen.host = "0.0.0.0" |
  .app.listen.port = 3000 |
  .app.baseUrl = strenv(KC_FRONTEND_URL) |
  .backend.listen.host = "0.0.0.0" |
  .backend.listen.port = 7007 |
  .backend.baseUrl = strenv(KC_BACKEND_URL) |
  .backend.cors.origin = strenv(KC_FRONTEND_URL)
' ./app-config.local.yaml
```{{exec}}

</details>
