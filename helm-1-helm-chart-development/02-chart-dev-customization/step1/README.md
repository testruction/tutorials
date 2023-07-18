# State the changes from module-1

Run the [bats-core](https://bats-core.readthedocs.io) script to catchup the tasks performed in the [01. Helm chart development (Initialization)]() module.

```bash
bats ~/module1.bats \
&& cd fastapi-sqlalchemy-cockroachdb
```{{exec}}

Check the local chart consistency with `--dry-run` argument to avoid connection to Kubernetes cluster.

```bash
helm template --dry-run chart/
```{{exec}}

> Next tasks will consist in getting the validation successful.
