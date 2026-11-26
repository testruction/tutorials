# Require a signature

Write a policy: every image from ttl.sh must be signed by your key.

```bash
cat > policy.yaml <<EOF
apiVersion: policy.sigstore.dev/v1beta1
kind: ClusterImagePolicy
metadata:
  name: signed-by-lab-key
spec:
  images:
    - glob: "ttl.sh/**"
  authorities:
    - name: lab-key
      key:
        data: |
$(sed 's/^/          /' cosign.pub)
EOF
kubectl apply -f policy.yaml
```{{exec}}

Run the signed image.

```bash
kubectl -n demo run signed --image=${SIGNED} -- sleep 3600
```{{exec}}

> If the request times out, run it again: the first verification downloads the Sigstore trust root.

Run the unsigned image.

```bash
kubectl -n demo run unsigned --image=${UNSIGNED} -- sleep 3600
```{{exec}}

The pod is rejected: `no signatures found`. The `default` namespace is not enabled, so the same image runs there.

```bash
kubectl -n default run unsigned --image=${UNSIGNED} -- sleep 3600
kubectl get pods --all-namespaces | grep signed
```{{exec}}
