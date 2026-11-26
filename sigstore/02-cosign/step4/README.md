# Add annotations to a signature

> If you opened a new terminal, set the variables again:
> `export COSIGN_PASSWORD='sigstore-lab' IMAGE=localhost:5000/demo/app@$(crane digest localhost:5000/demo/app:1.0)`{{exec}}

A signature can carry annotations: key-value pairs that are signed with the image digest. Sign the image again, for the staging environment.

```bash
cosign sign --yes --key cosign.key -a env=staging ${IMAGE}
```{{exec}}

Require the annotation at verification.

```bash
cosign verify --key cosign.pub -a env=staging ${IMAGE} | jq '.[].optional'
```{{exec}}

The image is not signed for production.

```bash
cosign verify --key cosign.pub -a env=production ${IMAGE}
```{{exec}}

> Annotations let a pipeline record *where* an image was approved. A deployment to production can then require a signature with `env=production`.
