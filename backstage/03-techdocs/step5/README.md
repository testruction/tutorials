# Browse the documentation

Run the Backstage application in development mode.

```bash
source ~/.bashrc
yarn start
```{{exec}}

> Wait for the message `webpack compiled successfully`.

[Click here]({{TRAFFIC_HOST1_3000}}) to open the Web console, then click **Enter** to sign in as guest.

1. Open the **techdocs-demo** component from the catalog.
2. Click on the **Docs** tab. The first display triggers the documentation build, which takes a few seconds.
3. Navigate to the **Getting started** page.
4. Open the **Docs** item of the sidebar to list all documentation sites.

> **Notice**:
> The **Docs** tab, the `/docs` index page and the reader page are extensions of the `techdocs` plugin. Their settings can be changed in the `app.extensions` section of the `app-config.yaml` file, for instance:
>
> ```yaml
> app:
>   extensions:
>     - entity-content:techdocs:
>         config:
>           title: Documentation
> ```
>
> The `/visualizer` page of the application lists all extensions and their identifiers.
