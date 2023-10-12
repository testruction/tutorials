# Implement Argo CD backend plugins

Install the `@roadiehq/backstage-plugin-argo-cd-backend` package in Backstage Backend component (i.e. `packages/backend`).

```bash
yarn add --cwd packages/backend @roadiehq/backstage-plugin-argo-cd-backend
```{{exec}}

Download the Argo CD backend initialization script to the plugin directory (i.e. `packages/backend/src/plugins`).

```bash
curl -sSL -o ${HOME}/backstage-tutorial/packages/backend/src/plugins/argocd.ts \
https://github.com/RoadieHQ/roadie-backstage-plugins/raw/main/packages/backend/src/plugins/argocd.ts
```{{exec}}

Edit the `backstage-tutorial/packages/backend/src/index.ts`, then insert the following content:

Above the line beginning by **`import { PluginEnvironment }`**.

```typescript
import argocd from './plugins/argocd';
```{{copy}}

In the **`main()`** function, above the line beginning by **`const appEnv`**.

```typescript
  const argocdEnv = useHotMemoize(module, () => createEnv('argocd'));
```{{copy}}

Bellow the line beginning by **`apiRouter.use('/search')`**.

```typescript
  apiRouter.use('/argocd', await argocd(argocdEnv));
```{{copy}}

<details><summary>Do it for me</summary>

```bash
yarn add --cwd packages/backend @roadiehq/backstage-plugin-argo-cd-backend

curl -sSL -o ${HOME}/backstage-tutorial/packages/backend/src/plugins/argocd.ts \
https://github.com/RoadieHQ/roadie-backstage-plugins/raw/main/packages/backend/src/plugins/argocd.ts

vi -e ${HOME}/backstage-tutorial/packages/backend/src/index.ts <<EOF
/import { PluginEnvironment }
i
import argocd from './plugins/argocd';
.
/const appEnv
i
  const argocdEnv = useHotMemoize(module, () => createEnv('argocd'));
.
/apiRouter.use.*search
a
  apiRouter.use('/argocd', await argocd(argocdEnv));
.
w
EOF
```{{exec}}

</details>
