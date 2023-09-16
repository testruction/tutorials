# Implement Prometheus frontend plugins

Install the `@roadiehq/backstage-plugin-prometheus` package in Backstage Frontend component (i.e. `packages/frontend`).

```bash
yarn add --cwd packages/app @roadiehq/backstage-plugin-prometheus
```{{exec}}

Edit the `backstage-tutorial/packages/app/src/components/catalog/EntityPage.tsx`, then insert the following content **without** the comments:

```typescript
// Below the line beginning by "import { ReportIssue }".
import {
  EntityPrometheusContent,
} from '@roadiehq/backstage-plugin-prometheus';
import {
  EntityPrometheusAlertCard,  
  EntityPrometheusGraphCard,
} from '@roadiehq/backstage-plugin-prometheus';

// In the "serviceEntityPage",
// Above the line "</EntityLayout>".
    <EntityLayout.Route path="/kubernetes" title="Kubernetes">
      <EntityKubernetesContent refreshIntervalMs={30000} />
    </EntityLayout.Route>

// In the "overviewContent",
// Below the line "<Grid container spacing={3} alignItems="stretch">".
    <Grid item md={8}>
      <EntityPrometheusAlertCard />
    </Grid>
    <Grid item md={6}>
      <EntityPrometheusGraphCard />
    </Grid>
```

<details><summary>Dot it for me</summary>

```typescript
vi -e packages/app/src/components/catalog/EntityPage.tsx <<EOF
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
/<Grid container
a
    <Grid item md={8}>
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
