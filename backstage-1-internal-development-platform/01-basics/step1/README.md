# Create Backstage application

Run the following command to create the Backage application named **backstage-tutorial**.

```bash
echo "backstage-tutorial" | npx @backstage/create-app@latest
```{{exec}}

> The creation process takes approximatly **5 minutes**.

Move to the newly created application directory

```bash
cd backstage-tutorial/
```{{exec}}

Create the application configuration to enable the frontend component to listen on all interfaces (i.e `0.0.0.0`).

```bash
yq -i '
  .app.listen.host = "0.0.0.0" |
  .app.listen.port = 3000 |
  .backend.listen.host = "0.0.0.0" |
  .backend.listen.port = 8080
' ./app-config.local.yaml
```{{exec}}

Update the application configuration to allow requests from Killercoda.

```bash
# Retreive the KillerCoda lab URL
export KC_FRONTEND_URL=$(cat /etc/killercoda/host | sed 's/PORT/3000/g')
export KC_BACKEND_URL=$(cat /etc/killercoda/host | sed 's/PORT/8080/g')
yq -i '
  .app.baseUrl = strenv(KC_FRONTEND_URL) |
  .backend.baseUrl = strenv(KC_BACKEND_URL) |
  .backend.cors.origin = strenv(KC_FRONTEND_URL)  
' ./app-config.local.yaml
```

Run the application in development mode.

```bash
yarn dev
```{{exec}}

[Click here to open the Web console]({{TRAFFIC_HOST1_3000}})
