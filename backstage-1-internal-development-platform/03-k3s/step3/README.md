# Implement Kubernetes backend plugins

Install the `@backstage/plugin-kubernetes-backend` package in Backstage Backend component (i.e. `packages/backend`).

```bash
yarn add --cwd packages/backend @backstage/plugin-kubernetes-backend
```{{exec}}

Download the Kubernetes backend initialization script to the plugin directory (i.e. `packages/backend/src/plugins`).

```bash
curl -o packages/backend/src/plugins/kubernetes.ts \
https://raw.githubusercontent.com/backstage/backstage/master/packages/backend/src/plugins/kubernetes.ts
```{{exec}}

Edit the **backstage-tutorial/packages/backend/src/index.ts**, then insert the following content **without** the comments:

```typescript
// Above the line beginning by "import { PluginEnvironment }"
import kubernetes from './plugins/kubernetes';
// Above the line beginning by "const appEnv"
const kubernetesEnv = useHotMemoize(module, () => createEnv('kubernetes'));
// Above the line beginning by "
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
/apiRouter.use
i
  apiRouter.use('/kubernetes', await kubernetes(kubernetesEnv));
.
wq
EOF
```{{exec}}
</details>
