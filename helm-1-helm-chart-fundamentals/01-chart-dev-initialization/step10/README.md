# Update Chart URLs and description

Add the source and home page URLs to the [chart definitions](https://helm.sh/docs/topics/charts/#the-chartyaml-file).

Retreive the URL from the git repository.

```bash
export SOURCE_URL=$(git config --get remote.origin.url)
```

**Sources**:

Allocate the `sources` list.

```bash
yq '.sources[0] = strenv(SOURCE_URL)' chart/Chart.yaml
```

**Home page**:

Allocate the `home` field.

```bash
yq '.home = strenv(SOURCE_URL)' chart/Chart.yaml
```

Update the Chart description.

```bash
yq '.description = strenv(SOURCE_URL)' chart/Chart.yaml
```

Commit changes.

```bash
git commit -a -m 'Added source URL to chart definition'
```
