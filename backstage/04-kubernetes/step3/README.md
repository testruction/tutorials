# Check the Kubernetes frontend plugin

Backstage applications now use the [new frontend system](https://backstage.io/docs/frontend-system/).
Plugins provide **extensions** (pages, entity tabs, entity cards, ...) which the application discovers automatically, so there is no longer an `EntityPage.tsx` file to edit.

The feature discovery is enabled by the following setting of the `app-config.yaml` file.

```bash
yq '.app.packages' app-config.yaml
```{{exec}}

> The value `all` tells Backstage to load every plugin listed in the `packages/app/package.json` file.

The application template already lists the `@backstage/plugin-kubernetes` package.

```bash
grep -n "plugin-kubernetes" packages/app/package.json
```{{exec}}

The plugin adds a **Kubernetes** tab to the entity pages. It is displayed only for entities having the `backstage.io/kubernetes-id` annotation.

> **Notice**:
> On an application that does not include the plugin yet, installing the package is enough.
>
> ```bash
> yarn --cwd packages/app add @backstage/plugin-kubernetes
> ```
>
> The tab can be disabled or customized from `app-config.yaml`, for example:
>
> ```yaml
> app:
>   extensions:
>     - entity-content:kubernetes/kubernetes:
>         config:
>           title: Workloads
> ```
