# Attach an SBOM attestation

> If you opened a new terminal, set the variables again:
> `export COSIGN_PASSWORD='sigstore-lab' IMAGE=localhost:5000/demo/app@$(crane digest localhost:5000/demo/app:1.0)`{{exec}}

An **attestation** is a signed [in-toto statement](https://github.com/in-toto/attestation): a subject (the image digest), a predicate type and a predicate (the content).

Generate the SBOM (Software Bill of Materials) of the image in the SPDX format.

```bash
syft scan registry:${IMAGE} -o spdx-json=sbom.spdx.json
jq -r '.packages[] | .name + " " + .versionInfo' sbom.spdx.json
```{{exec}}

Attach the SBOM to the image as an attestation.

```bash
cosign attest --yes --key cosign.key --type spdxjson --predicate sbom.spdx.json ${IMAGE}
cosign tree ${IMAGE}
```{{exec}}

Verify the attestation and read its predicate.

```bash
cosign verify-attestation --key cosign.pub --type spdxjson ${IMAGE} \
  | jq -r '.payload' | base64 -d \
  | jq -r '.predicateType, (.predicate.packages[] | .name + " " + .versionInfo)'
```{{exec}}

Ask for another predicate type.

```bash
cosign verify-attestation --key cosign.pub --type cyclonedx ${IMAGE}
```{{exec}}

> The consumers of the image get an SBOM that they can trust: it is signed by your key, and bound to the digest of the image.
