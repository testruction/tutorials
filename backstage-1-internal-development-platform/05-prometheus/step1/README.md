# Implement Prometheus frontend plugins

Install the `@roadiehq/backstage-plugin-prometheus` package in Backstage Frontend component (i.e. `packages/frontend`).

```bash
yarn add --cwd packages/app @roadiehq/backstage-plugin-prometheus
```{{exec}}

Edit the `backstage-tutorial/packages/app/src/components/catalog/EntityPage.tsx`, then insert the following content **without** the comments:

Below the line beginning by "import { ReportIssue }".

```typescript
import {
  EntityPrometheusContent,
} from '@roadiehq/backstage-plugin-prometheus';
import {
  EntityPrometheusAlertCard,  
  EntityPrometheusGraphCard,
} from '@roadiehq/backstage-plugin-prometheus';
```

Prometheus can be integrated either via a widget or an entity page (i.e. a section of the ).

> **Notice**:
> Entity page integratoin is recommanded as it integrates nicely with the default Backstage layout.

At the **serviceEntityPage**, above the line "</EntityLayout>".

<details><summary><b>Entity Page instegration</b></summary>

```typescript
    <EntityLayout.Route path="/kubernetes" title="Kubernetes">
      <EntityKubernetesContent refreshIntervalMs={30000} />
    </EntityLayout.Route>

```

</details>

<details><summary><b>(alternative): Widget integration</b></summary>

At the **overviewContent**, below the line "{entityWarningContent}".

```typescript
    <Grid item md={8}>
      <EntityPrometheusAlertCard />
    </Grid>
    <Grid item md={6}>
      <EntityPrometheusGraphCard />
    </Grid>
```

</details>

---

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
w
EOF
```{{exec}}

</details>
