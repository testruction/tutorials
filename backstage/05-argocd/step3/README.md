# Implement Argo CD frontend plugins

Install the `@roadiehq/backstage-plugin-argo-cd` package in Backstage Frontend component (i.e. `packages/frontend`).

```bash
yarn add --cwd packages/app @roadiehq/backstage-plugin-argo-cd
```{{exec}}

Edit the `backstage-tutorial/packages/app/src/components/catalog/EntityPage.tsx`, then insert the following content **without** the comments:

Below the line beginning by **`import { ReportIssue }`**.

```typescript
import {
  EntityArgoCDOverviewCard,
  isArgocdAvailable
} from '@roadiehq/backstage-plugin-argo-cd';
```

<!--At the **`serviceEntityPage`**, above the line **`</EntityLayout>`**.

```typescript
    <EntityLayout.Route path="/kubernetes" title="Kubernetes">
      <EntityKubernetesContent refreshIntervalMs={30000} />
    </EntityLayout.Route>
``` -->

At the **`overviewContent`**, below the line **`{entityWarningContent}`**.

```typescript
    <EntitySwitch>
      <EntitySwitch.Case if={e => Boolean(isArgocdAvailable(e))}>
        <Grid item sm={12}>
          <EntityArgoCDOverviewCard />
        </Grid>
      </EntitySwitch.Case>
    </EntitySwitch>
```

<details><summary>Dot it for me</summary>

```typescript
vi -e ${HOME}/backstage-tutorial/packages/app/src/components/catalog/EntityPage.tsx <<EOF
/import { ReportIssue }
a
import {
  EntityArgoCDOverviewCard,
  isArgocdAvailable
} from '@roadiehq/backstage-plugin-argo-cd';
.
/const overviewContent
/{entityWarningContent}
a

    <EntitySwitch>
      <EntitySwitch.Case if={e => Boolean(isArgocdAvailable(e))}>
        <Grid item sm={4}>
          <EntityArgoCDOverviewCard />
        </Grid>
      </EntitySwitch.Case>
    </EntitySwitch>

.
w
EOF
```{{exec}}

</details>
