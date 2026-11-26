# Push and sign the images

Generate a key pair.

```bash
export COSIGN_PASSWORD='sigstore-lab'
cosign generate-key-pair
```{{exec}}

Push two images to ttl.sh under a random name.

```bash
REPO=ttl.sh/sigstore-$(cat /proc/sys/kernel/random/uuid | cut -c 1-8)
crane copy --platform linux/amd64 alpine:3.22 ${REPO}-signed:1h
crane copy --platform linux/amd64 busybox:1.37 ${REPO}-unsigned:1h
SIGNED=${REPO}-signed@$(crane digest ${REPO}-signed:1h)
UNSIGNED=${REPO}-unsigned@$(crane digest ${REPO}-unsigned:1h)
echo -e "${SIGNED}\n${UNSIGNED}"
```{{exec}}

Sign the first image.

```bash
cosign sign --yes --key cosign.key --new-bundle-format=false --use-signing-config=false ${SIGNED}
cosign tree ${SIGNED}
```{{exec}}

> **Notice**:
> Cosign 3 stores signatures as Sigstore bundles by default, and the Policy Controller only reads bundles made with a Fulcio certificate. The two flags store a signature with a key in the previous (`legacy`) format, a `.sig` tag next to the image. Cosign warns that they are deprecated.
