# Configure Killercoda reverse-proxy URL

Update the application configuration to allow access through the Killercoda environment.

```bash
# Retreive the KillerCoda instance URL
export KC_FRONTEND_URL=$(cat /etc/killercoda/host | sed -e 's/PORT/3000/' -e 's/https/http/')
export KC_BACKEND_URL=$(cat /etc/killercoda/host | sed 's/PORT/7007/')

yq -i '
  .app.baseUrl = strenv(KC_FRONTEND_URL) |
  .backend.baseUrl = strenv(KC_BACKEND_URL) |
  .backend.cors.origin = strenv(KC_FRONTEND_URL)  
' ./app-config.local.yaml
```
