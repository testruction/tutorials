# Implement Prometheus frontend plugins

Install the `@roadiehq/backstage-plugin-prometheus` package in Backstage Frontend component (i.e. `packages/frontend`).

```bash
yarn add --cwd packages/app @roadiehq/backstage-plugin-prometheus
```{{exec}}

Edit the `backstage-tutorial/packages/app/src/components/catalog/EntityPage.tsx`, then insert the following content **without** the comments:

Below the line beginning by **`import { ReportIssue }`**.

```typescript
import {
  EntityPrometheusContent,
} from '@roadiehq/backstage-plugin-prometheus';
import {
  EntityPrometheusAlertCard,  
  EntityPrometheusGraphCard,
} from '@roadiehq/backstage-plugin-prometheus';
```

At the **`serviceEntityPage`**, above the line **`</EntityLayout>`**.

```typescript
    <EntityLayout.Route path="/kubernetes" title="Kubernetes">
      <EntityKubernetesContent refreshIntervalMs={30000} />
    </EntityLayout.Route>
```

At the **`overviewContent`**, below the line **`{entityWarningContent}`**.

```typescript
    <Grid item md={6}>
      <EntityPrometheusAlertCard />
    </Grid>
    <Grid item md={6}>
      <EntityPrometheusGraphCard />
    </Grid>
```

<details><summary>Dot it for me</summary>

```typescript
vi -e ${HOME}/backstage-tutorial/packages/app/src/components/catalog/EntityPage.tsx <<EOF
/import { ReportIssue }
a
import {
  EntityPrometheusContent,
} from '@roadiehq/backstage-plugin-prometheus';
import {
  EntityPrometheusAlertCard,  
  EntityPrometheusGraphCard,
} from '@roadiehq/backstage-plugin-prometheus';
.
/const serviceEntityPage
/<\/EntityLayout>
i

    <EntityLayout.Route path="/prometheus" title="Prometheus">
      <EntityPrometheusContent />
    </EntityLayout.Route>
.
/const overviewContent
/{entityWarningContent}
a

    <Grid item md={6}>
      <EntityPrometheusAlertCard />
    </Grid>
    <Grid item md={6}>
      <EntityPrometheusGraphCard />
    </Grid>

.
w
EOF
```{{exec}}

</details>
