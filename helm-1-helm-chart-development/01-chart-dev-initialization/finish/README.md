# Next steps

> The initial chart configuration is now finished.
> The next steps will focus on the Database and Trace collector implementation

Check the local chart consistency with `--dry-run` argument to avoid connection to Kubernetes cluster.

```bash
helm template --dry-run chart/
```{{exec}}

Stage and commit changes before continuing.

```bash
git commit -a -m 'Finalized initial chart developement'
```{{exec}}
