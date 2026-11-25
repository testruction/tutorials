# Implement the Argo CD frontend plugin

Install the `@roadiehq/backstage-plugin-argo-cd` package in the Backstage frontend component (i.e. `packages/app`).

```bash
yarn --cwd ${HOME}/backstage-tutorial/packages/app add @roadiehq/backstage-plugin-argo-cd
```{{exec}}

Backstage uses the [new frontend system](https://backstage.io/docs/frontend-system/). The package exposes its extensions through the `@roadiehq/backstage-plugin-argo-cd/alpha` entry point, which is discovered automatically because `app.packages` is set to `all` in the `app-config.yaml` file.

There is **no** `EntityPage.tsx` file to edit anymore. The plugin provides the following extensions:

* The **Argo CD overview card** and **history card** displayed on the entity overview tab.
* The Argo CD API client.

> **Notice**:
> The cards are displayed only on entities having the `argocd/app-name` annotation, which is added later in this lab.

The installed extensions can be inspected from the application, at the `/visualizer` page.
