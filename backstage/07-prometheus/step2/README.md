# Implement the Prometheus frontend plugin

Install the `@roadiehq/backstage-plugin-prometheus` package in the Backstage frontend component (i.e. `packages/app`).

```bash
yarn --cwd ${HOME}/backstage-tutorial/packages/app add @roadiehq/backstage-plugin-prometheus
```{{exec}}

Backstage uses the [new frontend system](https://backstage.io/docs/frontend-system/): there is no `EntityPage.tsx` file to edit anymore. UI elements are **extensions** provided by plugins and discovered automatically.

The Roadie Prometheus plugin still exposes **legacy** React components only (`EntityPrometheusContent`, `EntityPrometheusAlertCard` and `EntityPrometheusGraphCard`).
To use them in the new frontend system, wrap them in extensions created from the catalog blueprints, and group these extensions in a **frontend module** attached to the `catalog` plugin.

Create the `backstage-tutorial/packages/app/src/modules/prometheus/index.tsx` file with the following content.

```tsx
import { createFrontendModule } from '@backstage/frontend-plugin-api';
import {
  EntityCardBlueprint,
  EntityContentBlueprint,
} from '@backstage/plugin-catalog-react/alpha';

const hasPrometheusRule = (entity: {
  metadata: { annotations?: Record<string, string> };
}) => Boolean(entity.metadata.annotations?.['prometheus.io/rule']);

const prometheusContent = EntityContentBlueprint.make({
  name: 'prometheus',
  params: {
    path: '/prometheus',
    title: 'Prometheus',
    filter: hasPrometheusRule,
    loader: () =>
      import('@roadiehq/backstage-plugin-prometheus').then(m => (
        <m.EntityPrometheusContent />
      )),
  },
});

const prometheusAlertCard = EntityCardBlueprint.make({
  name: 'prometheus-alerts',
  params: {
    type: 'content',
    filter: hasPrometheusRule,
    loader: () =>
      import('@roadiehq/backstage-plugin-prometheus').then(m => (
        <m.EntityPrometheusAlertCard />
      )),
  },
});

const prometheusGraphCard = EntityCardBlueprint.make({
  name: 'prometheus-graph',
  params: {
    type: 'content',
    filter: hasPrometheusRule,
    loader: () =>
      import('@roadiehq/backstage-plugin-prometheus').then(m => (
        <m.EntityPrometheusGraphCard />
      )),
  },
});

export const prometheusModule = createFrontendModule({
  pluginId: 'catalog',
  extensions: [prometheusContent, prometheusAlertCard, prometheusGraphCard],
});
```

The extensions are displayed only for entities having the `prometheus.io/rule` annotation, which is added later in this lab.

Edit the `backstage-tutorial/packages/app/src/App.tsx` file to register the module.

```typescript
// Add the import
import { prometheusModule } from './modules/prometheus';

// Add the module to the `features` list
export default createApp({
  features: [catalogPlugin, navModule, homeModule, prometheusModule],
});
```

<details><summary>Do it for me</summary>

```bash
APP_DIR=${HOME}/backstage-tutorial/packages/app
mkdir -p ${APP_DIR}/src/modules/prometheus
cat > ${APP_DIR}/src/modules/prometheus/index.tsx <<'EOF'
import { createFrontendModule } from '@backstage/frontend-plugin-api';
import {
  EntityCardBlueprint,
  EntityContentBlueprint,
} from '@backstage/plugin-catalog-react/alpha';

const hasPrometheusRule = (entity: {
  metadata: { annotations?: Record<string, string> };
}) => Boolean(entity.metadata.annotations?.['prometheus.io/rule']);

const prometheusContent = EntityContentBlueprint.make({
  name: 'prometheus',
  params: {
    path: '/prometheus',
    title: 'Prometheus',
    filter: hasPrometheusRule,
    loader: () =>
      import('@roadiehq/backstage-plugin-prometheus').then(m => (
        <m.EntityPrometheusContent />
      )),
  },
});

const prometheusAlertCard = EntityCardBlueprint.make({
  name: 'prometheus-alerts',
  params: {
    type: 'content',
    filter: hasPrometheusRule,
    loader: () =>
      import('@roadiehq/backstage-plugin-prometheus').then(m => (
        <m.EntityPrometheusAlertCard />
      )),
  },
});

const prometheusGraphCard = EntityCardBlueprint.make({
  name: 'prometheus-graph',
  params: {
    type: 'content',
    filter: hasPrometheusRule,
    loader: () =>
      import('@roadiehq/backstage-plugin-prometheus').then(m => (
        <m.EntityPrometheusGraphCard />
      )),
  },
});

export const prometheusModule = createFrontendModule({
  pluginId: 'catalog',
  extensions: [prometheusContent, prometheusAlertCard, prometheusGraphCard],
});
EOF
sed -i \
  -e "0,/^import .*;$/s//&\nimport { prometheusModule } from '.\/modules\/prometheus';/" \
  -e 's/features: \[/features: [prometheusModule, /' \
  ${APP_DIR}/src/App.tsx
```{{exec}}

</details>
