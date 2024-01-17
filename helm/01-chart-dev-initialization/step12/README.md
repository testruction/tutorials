# 12. Create tests

> So far the chart tests were not modified and are still pointing to a single application component.

Create a dedicated template to test the API service of the `backend` component.

```bash
cp -v chart/templates/tests/test-connection.yaml \
      chart/templates/tests/test-backend-service.yaml
```{{exec}}

Update the tested URL in order to query 5 `backend` API objects.

> **Notice**:
> The following command line demonstrates how to apply multiple changes using an single `sed` instance.
> Only intermediate changes are specified using the `--expression (-e)` argument, and the last with the `--in-place (-i)` which effectively write all changes to the file.
> The expression separator has been changed from "/" to "#" to better distinguish the `sed` command segments.

```bash
sed \
-e 's#\(test\)-connection#\1-backend-service#g' \
-e 's#\(\}\}\)\(:\)#\1-backend\2#g' \
-e 's#\(.Values\)\(.service.port\)#\1.backend\2#g' \
-e 's#\(.service.port\s\}\}\)#\1/apis/v1/fakenames?limit=5#g' \
-i chart/templates/tests/test-backend-service.yaml
```{{exec}}

Create another template to test the home page of the `frontent` service component.

```bash
cp -v chart/templates/tests/test-connection.yaml \
      chart/templates/tests/test-frontend-service.yaml

sed \
-e 's#\(test\)-connection#\1-frontend-service#g' \
-e 's#\(\}\}\)\(:\)#\1-frontend\2#g' \
-e 's#\(.Values\)\(.service.port\)#\1.frontend\2#g' \
-i chart/templates/tests/test-frontend-service.yaml
```{{exec}}

Remove the de default test template.

```bash
rm -f chart/templates/tests/test-connection.yaml
```{{exec}}
