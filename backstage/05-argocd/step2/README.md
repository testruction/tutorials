# Implement Argo CD backend plugins

Install the `@roadiehq/backstage-plugin-argo-cd-backend` package in Backstage Backend component (i.e. `packages/backend`).

```bash
yarn add --cwd packages/backend @roadiehq/backstage-plugin-argo-cd-backend
```{{exec}}

Download the Kubernetes backend initialization script to the plugin directory (i.e. `packages/backend/src/plugins`).

```bash
curl -o packages/backend/src/plugins/kubernetes.ts \
https://raw.githubusercontent.com/backstage/backstage/master/packages/backend/src/plugins/kubernetes.ts
```{{exec}}

Edit the `backstage-tutorial/packages/backend/src/index.ts`, then insert the following content:

Above the line beginning by **`import { PluginEnvironment }`**.

```typescript
import argocd from './plugins/argocd';
```{{copy}}

In the **`main()`** function, above the line beginning by **`const appEnv`**.

```typescript
  const kubernetesEnv = useHotMemoize(module, () => createEnv('kubernetes'));
```{{copy}}

Bellow the line beginning by **`apiRouter.use('/search')`**.

```typescript
  apiRouter.use('/kubernetes', await kubernetes(kubernetesEnv));
```{{copy}}

<details><summary>Do it for me</summary>

```bash
cat << EOF > ${HOME}/backstage-tutorial/packages/backend/src/plugins/argocd.ts
import { createRouter } from '@roadiehq/backstage-plugin-argo-cd-backend';
import { PluginEnvironment } from '../types';

export default async function createPlugin({
  logger,
  config,
}: PluginEnvironment) {
  return await createRouter({ logger, config });
}
EOF


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
