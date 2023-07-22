# Access the application

Test application components to check if the deployment is successful

```bash
cat <<EOF > ~/.validate.bats
#!/usr/bin/env bats
setup() {
  RELEASE_NAME="chartdev"
}

@test "Check backend API" {
  HOST=$(kubectl get svc chartdev-fastapi-backend -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
  PORT=$(kubectl get svc chartdev-fastapi-backend -o jsonpath='{.spec.ports[?(@.name == "grpc")].nodePort}')

  curl "http://${HOST}:${PORT}/health"
  curl "http://${HOST}:${PORT}/v1/fakenames?limit=5"
}

@test "Check frontend API" {
  HOST=$(kubectl get svc chartdev-fastapi-frontend -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
  PORT=$(kubectl get svc chartdev-fastapi-frontend -o jsonpath='{.spec.ports[?(@.name == "grpc")].nodePort}')
  
  curl "http://$HOST}:${PORT}/health"
  curl "http://$HOST}:${PORT}/"
}
EOF

bats ~/validate.bats
```

Access the application components using the flowing URLs to check if the deployment .

* [CockroachDB UI]({{TRAFFIC_HOST1_8080}})
* [Backend API documentation]({{TRAFFIC_HOST1_8001}}/v1/docs)
* [Frontend UI]({{TRAFFIC_HOST1_8000}}/)