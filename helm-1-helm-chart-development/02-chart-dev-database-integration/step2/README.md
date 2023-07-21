# Add environment variables support

A good practice is to implement two level of environment support to support scenarios listed below:

Section | Description
--- | ---
**`env: []`** | Well-known variables supported by the application
**`extraEnv: []`** | Temporary variables (i.e test, debug, etc.)

Add the environment variables support to both `backend` and `frontend` components for future purposes.

```bash
yq -i '
  .backend.env = []
  .backend.extraEnv = []
  .frontend.env = []
  .frontend.extraEnv = []
' chart/values.yaml
```{{exec}}
