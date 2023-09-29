# # Implement Kubernetes frontend plugins

Install the `@backstage/plugin-kubernetes` package in Backstage Frontend component (i.e. `packages/frontend`).

```bash
yarn add --cwd packages/app @backstage/plugin-kubernetes
```{{exec}}

Edit the `backstage-tutorial/packages/app/src/components/catalog/EntityPage.tsx`, then insert the following content **without** the comments:

```typescript
// Below the line beginning by "import { ReportIssue }".
import { EntityKubernetesContent } from '@backstage/plugin-kubernetes';

// In the "serviceEntityPage",
// Above the line "</EntityLayout>".
    <EntityLayout.Route path="/kubernetes" title="Kubernetes">
      <EntityKubernetesContent refreshIntervalMs={30000} />
    </EntityLayout.Route>
```

<details><summary>Dot it for me</summary>

```typescript
vi -e packages/app/src/components/catalog/EntityPage.tsx <<EOF
/import { ReportIssue }
a
import { EntityKubernetesContent } from '@backstage/plugin-kubernetes';
.
/const serviceEntityPage
/<\/EntityLayout>
i

    <EntityLayout.Route path="/kubernetes" title="Kubernetes">
      <EntityKubernetesContent refreshIntervalMs={30000} />
    </EntityLayout.Route>
.
w
EOF
```{{exec}}

</details>
