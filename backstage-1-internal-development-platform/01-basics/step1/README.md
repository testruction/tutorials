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

By the default the Backstage frontend and backend components listens only on the `localhost (127.0.0.1)` interface.
Create the application configuration to enable the frontend component to listen on all interfaces (i.e `0.0.0.0`).

```bash
yq -i '
  .app.listen.host = "0.0.0.0" |
  .backend.listen.host = "0.0.0.0"
' ./app-config.local.yaml
```{{exec}}

The `app-config.local.yaml` takes precedence on the default `app-config.yaml` configuration file delivered at the application creation.

```bash
yq . load(./app-config.local.yaml) ./app-config.yaml
```
