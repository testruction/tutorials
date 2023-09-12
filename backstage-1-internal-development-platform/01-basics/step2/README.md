# Configure access from KillerCoda

In developmenet, the Backstage `frontend` and `backend` components listens only on the `localhost (127.0.0.1)` interface , respectively on ports `3000/tcp` and `7007/tcp`.

In order to enable external access in development mode, settings must be added to the `./app-config.local.yaml` file which overrides the default `./app-config.yaml`.

Run the following command line to enable the frontend component to listen on all interfaces (i.e `0.0.0.0`) and accept the traffic from the KillerCoda proxy.

```bash
# Retreive the KillerCoda instance URL
export KC_FRONTEND_URL=$(cat /etc/killercoda/host | sed -e 's/PORT/3000/' -e 's/https/http/')
export KC_BACKEND_URL=$(cat /etc/killercoda/host | sed 's/PORT/7007/')

yq -i '
  .app.listen.host = "0.0.0.0" |
  .app.baseUrl = strenv(KC_FRONTEND_URL) |
  .backend.listen.host = "0.0.0.0" |
  .backend.baseUrl = strenv(KC_BACKEND_URL) |
  .backend.cors.origin = strenv(KC_FRONTEND_URL)
' ./app-config.local.yaml
```
