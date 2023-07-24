# Validate the chart and record the changes

Check the resolved environment variables

```bash
helm template chart/ | jq '.spec.template.spec.containers[0].env
```{{exec}}

Commit the change in Git

```bash
git commit -a -m "Add trace collector support"
```{{exec}}
