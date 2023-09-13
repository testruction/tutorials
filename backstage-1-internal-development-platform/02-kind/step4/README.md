# # Implement Kubernetes frontend plugins

Install the `@backstage/plugin-kubernetes` package in Backstage Frontend component (i.e. `packages/frontend`).

```bash
yarn add --cwd packages/app @backstage/plugin-kubernetes
```{{exec}}

Inject the plugin service page in the Frontend `packages/app/src/components/catalog/EntityPage.tsx`:

1. Insert the module import.

```typescript
vi -e packages/app/src/components/catalog/EntityPage.tsx <<EOF
/import { TechDocsAddons }
i
import { EntityKubernetesContent } from '@backstage/plugin-kubernetes';
.
wq
EOF
```{{exec}}

2. Insert the route to the plugin entity.

```typescript
vi -e packages/app/src/components/catalog/EntityPage.tsx <<EOF
/const serviceEntityPage
/techdocsContent
/<\/EntityLayout>
i

    <EntityLayout.Route path="/kubernetes" title="Kubernetes">
      <EntityKubernetesContent refreshIntervalMs={30000} />
    </EntityLayout.Route>
.
wq
EOF
```{{exec}}