# Enable the Policy Controller

Check that the webhook runs.

```bash
kubectl -n cosign-system get pods
kubectl get validatingwebhookconfigurations,mutatingwebhookconfigurations | grep sigstore
```{{exec}}

The webhook only handles the namespaces that opt in with the `policy.sigstore.dev/include=true` label. Create a namespace and enable it.

```bash
kubectl create namespace demo
kubectl label namespace demo policy.sigstore.dev/include=true
```{{exec}}

> In an enabled namespace, a pod is rejected when an image matches **no** policy at all. The controller also resolves tags to digests, so that the image that was verified is the image that runs.
