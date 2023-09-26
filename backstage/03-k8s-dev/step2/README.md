# Implement Kubernetes backend plugins

Install the `@backstage/plugin-kubernetes-backend` package in Backstage Backend component (i.e. `packages/backend`).

```bash
yarn add --cwd packages/backend @backstage/plugin-kubernetes-backend
```{{exec}}

Download the Kubernetes backend initialization script to the plugin directory (i.e. `packages/backend/src/plugins`).

```bash
curl -sSL -o packages/backend/src/plugins/kubernetes.ts \
https://github/backstage/backstage/raw/master/packages/backend/src/plugins/kubernetes.ts
```{{exec}}

Edit the `backstage-tutorial/packages/backend/src/index.ts`, then insert the following content **without** the comments:

```typescript
// Above the line beginning by "import { PluginEnvironment }"
import kubernetes from './plugins/kubernetes';

// In the main() function
// Above the line beginning by "const appEnv"
  const kubernetesEnv = useHotMemoize(module, () => createEnv('kubernetes'));
// Bellow the line beginning by "apiRouter.use('/search')
  apiRouter.use('/kubernetes', await kubernetes(kubernetesEnv));
```

<details><summary>Do it for me</summary>

```typescript
vi -e packages/backend/src/index.ts <<EOF
/import { PluginEnvironment }
i
import kubernetes from './plugins/kubernetes';
.
/const appEnv
i
  const kubernetesEnv = useHotMemoize(module, () => createEnv('kubernetes'));
.
/apiRouter.use.*search
a
  apiRouter.use('/kubernetes', await kubernetes(kubernetesEnv));
.
w
EOF
```{{exec}}

</details>
