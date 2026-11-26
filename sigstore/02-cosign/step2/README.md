# Sign a container image

Copy an image to the local registry.

```bash
crane copy --platform linux/amd64 busybox:1.37 localhost:5000/demo/app:1.0
```{{exec}}

A tag can be moved to another image at any time: always sign and verify an image by its **digest**.

```bash
IMAGE=localhost:5000/demo/app@$(crane digest localhost:5000/demo/app:1.0)
echo ${IMAGE}
```{{exec}}

Sign the image. Cosign stores the signature in the registry, next to the image.

```bash
cosign sign --yes --key cosign.key ${IMAGE}
```{{exec}}

Verify the image. The output is the signed payload: the digest of the image and its repository.

```bash
cosign verify --key cosign.pub ${IMAGE} | jq
```{{exec}}

List what is attached to the image.

```bash
cosign tree ${IMAGE}
```{{exec}}

> The signature is an OCI artifact linked to the image with the [OCI referrers API](https://github.com/opencontainers/distribution-spec/blob/main/spec.md#listing-referrers). It follows the image when it is copied with a tool that supports referrers.
