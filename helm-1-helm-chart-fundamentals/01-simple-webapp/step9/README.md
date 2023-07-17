# Updated container port

Update the listening port to match the FastAPI default listen port.

Open the `backend` deployment template.

```bash
vi chart/templates/backend/deployment.yaml
```{{exec}}

1. Type **`/containerPort`** to position du cursor to the port exposed by the containerized service.
2. Type `:s/containerPort: 80/containerPort: 8000` to change the port from `80` to `8000`
3. type **`:wq`** to save the change and quit `vi` 

Repeat the same operations for the `frontend` deployment.
