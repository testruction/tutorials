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

Update the application configuration to enable the frontend component to listen on all interfaces (i.e `0.0.0.0`).

```bash
yq -i '
  .app.listen.host = "0.0.0.0" |
  .app.listen.port = 3000
' ./app-config.local.yaml
```{{exec}}

Run the application in development mode.

```bash
yarn dev
```{{exec}}
