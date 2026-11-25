# Check the TechDocs plugins

The application template already includes TechDocs, so nothing needs to be installed.

## Backend

The backend registers the TechDocs plugin and its search collator with the [new backend system](https://backstage.io/docs/backend-system/).

```bash
grep -n "techdocs" packages/backend/src/index.ts
```{{exec}}

## Frontend

The frontend of the new frontend system discovers plugins listed in `packages/app/package.json`, as long as the `app.packages` setting is set to `all`.

```bash
yq '.app.packages' app-config.yaml
grep -n "techdocs" packages/app/package.json
```{{exec}}

The following packages provide the user interface.

Package | Provides
--- | ---
`@backstage/plugin-techdocs` | The **Docs** entity tab, the documentation index page and the documentation reader page
`@backstage/plugin-techdocs-module-addons-contrib` | Optional reader add-ons (e.g. *Report issue*, *Text size*, *Expandable navigation*, *Light box*)

> **Notice**:
> With the previous (legacy) frontend system, these plugins required manual changes of `App.tsx` (routes and `TechDocsAddons`) and `EntityPage.tsx` (the `EntityLayout.Route` for docs). These changes are not needed anymore.
