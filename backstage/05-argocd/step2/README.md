# Implement the Argo CD backend plugin

Install the `@roadiehq/backstage-plugin-argo-cd-backend` package in the Backstage backend component (i.e. `packages/backend`).

```bash
yarn --cwd ${HOME}/backstage-tutorial/packages/backend add @roadiehq/backstage-plugin-argo-cd-backend
```{{exec}}

Backstage uses the [new backend system](https://backstage.io/docs/backend-system/). The plugin is registered with a single line, and the legacy `plugins/argocd.ts` router and `PluginEnvironment` wiring are no longer needed.

Edit the `backstage-tutorial/packages/backend/src/index.ts` file, then add the following line above `backend.start();`.

```typescript
backend.add(import('@roadiehq/backstage-plugin-argo-cd-backend'));
```{{copy}}

<details><summary>Do it for me</summary>

```bash
sed -i "/^backend.start();/i backend.add(import('@roadiehq/backstage-plugin-argo-cd-backend'));" \
${HOME}/backstage-tutorial/packages/backend/src/index.ts
```{{exec}}

</details>
