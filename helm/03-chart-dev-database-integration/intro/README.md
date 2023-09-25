## Database dependency integration

> **Disclaimer**: This module is the continuation of the [02. Helm chart development (Database Integration)](https://killercoda.com/florianjudithb/course/helm-1-helm-chart-development/02-chart-dev-database-integration).
> From a learning perspective, it is highly recommended to complete this module before starting to this one.
> However, this course is designed to run any modules in any order.

The previous module consisted in initializing a chart for new application composed of a backend and frontend application.

### Learning objectives

The objectives of this module is to learn how to:

- Add a database dependency to the chart
- Secure credentials to access the database
- Implement dedicated environment variables required for the component networking
- Get even more hands-on experience on `git`, `sed`, `vi` and `yq` tools

### References

The following sources were used to build this lab.

- Helm official documentation: <https://helm.sh/docs/>
- CockroachDB official chart: <https://artifacthub.io/packages/helm/cockroachdb/cockroachdb>
