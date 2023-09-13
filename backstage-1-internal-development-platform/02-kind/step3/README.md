# Implement Kubernetes plugins

Install the `@backstage/plugin-kubernetes-backend` package in Backstage Backend component (i.e. `packages/backend`).

```bash
yarn add --cwd packages/backend @backstage/plugin-kubernetes-backend
```{{exec}}

Download the Kubernetes backend initialization script to the plugin directory (i.e. `packages/backend/src/plugins`).

```bash
curl -o packages/backend/src/plugins/kubernetes.ts \
https://raw.githubusercontent.com/backstage/backstage/master/packages/backend/src/plugins/kubernetes.ts
```{{exec}}

Inject the plugin in the main Backend script `packages/backend/src/index.ts`:

1. Insert the module import.

```typescript
vi -e packages/backend/src/index.ts <<EOF
/import { PluginEnvironment }
i
import kubernetes from './plugins/kubernetes';
.
wq
EOF
```{{exec}}

2. Insert the module environment initialization

```typescript
vi -e packages/backend/src/index.ts <<EOF
/const appEnv
i
  const kubernetesEnv = useHotMemoize(module, () => createEnv('kubernetes'));
.
wq
EOF
```{{exec}}

3. Insert the module route.

```typescript
vi -e packages/backend/src/index.ts <<EOF
/apiRouter.use
i
  apiRouter.use('/kubernetes', await kubernetes(kubernetesEnv));
.
wq
EOF
```{{exec}}
