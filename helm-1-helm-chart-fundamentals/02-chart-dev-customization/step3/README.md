# Update the helpers script and deployment notes

The Helper scripts include conditions to determine wether a resource should be created.
Currently the evaluation of Service Account creation needs to updated in order to handle both `backend` and `frontend` account provisionning.

Add a new global configuration section to evaluate the service account creation.

> **Note**:
> The following command line demonstrates how to apply multiple changes using a single `yq` instance.
> Notice that boolean value is not surrounded by quotes `""`.

```bash
yq -i '
  .global.serviceAccount.create = true |
  .global.serviceAccount.name = ""
' chart/values.yaml
```{{exec}}

Update the helpers script to rely on the new global property.

```bash
sed -i 's#\(.Values\)\(.serviceAccount\)#\1.global\2#g' chart/templates/_helpers.tpl
```{{exec}}

sed -i 's#\(.Values\)\(.serviceAccount\)#\1.global\2#g' chart/templates/**/serviceaccount.yaml

Update the deployment notes to display the `frontend` URL.

```bash
sed \
-e 's#\(.Values\)\(.*\)#\1.frontend\2#g' \
-i chart/templates/NOTES.txt
```
