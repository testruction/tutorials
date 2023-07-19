# Update Chart URLs and description

Add the source and home page URLs to the [chart definitions](https://helm.sh/docs/topics/charts/#the-chartyaml-file).

Retreive the URL from the git repository.

```bash
export SOURCE_URL=$(git config --get remote.origin.url)
```{{exec}}

Allocate the `sources` list.

```bash
yq -i '.sources[0] = strenv(SOURCE_URL)' chart/Chart.yaml
```{{exec}}

Allocate the `home` field.

```bash
yq -i '.home = strenv(SOURCE_URL)' chart/Chart.yaml
```{{exec}}

Update the chart name.

```bash
yq -i '.name = "fastapi"' chart/Chart.yaml
```{{exec}}

Update the Chart description.

```bash
yq -i '.description = strenv(SOURCE_URL)' chart/Chart.yaml
```{{exec}}

Update the application version to match the images published in the registry.

```bash
yq -i '.appVersion = "1.0.0"'  chart/Chart.yaml
```{{exec}}

Check the chart definition changes.

```bash
helm show chart chart/
```{{exec}}

Commit changes.

```bash
git commit -a -m 'Added source URL to chart definition'
```{{exec}}
