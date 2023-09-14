# Enable external access

The Backstage frontend and backend default configuration allows connection only from the `localhost (127.0.0.1), on the port **7007/tcp**.

In order to enable the access outside of the local host/container, the base URL of the **frontend** and **backend** have to be updated from **http://localhost:70007** to the custom URL.

In the case of KillerCoda, this URL is stored in the **/etc/killercoda/host** file.

Copy the entire URL from this file then edit the **app-config.local.yaml** configuration file.
Replace both backend and frontend base URLs and change the **PORT** mentionned in the URL by **7007**.

This should look similar to the example below:

```yaml
app:
  baseUrl: https://xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx-x-x-x-x-7007.saci.r.killercoda.com

backend:
  baseUrl: https://xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx-x-x-x-x-7007.saci.r.killercoda.com
```

<details><summary>Do it for me</summary>

```bash
# Retreive the KillerCoda instance URL
export KC_URL=$(cat /etc/killercoda/host | sed 's/PORT/7007/')

yq -i '
  .app.baseUrl = strenv(KC_URL) |
  .backend.baseUrl = strenv(KC_URL) |
' ./app-config.production.yaml
```{{exec}}

</details>
