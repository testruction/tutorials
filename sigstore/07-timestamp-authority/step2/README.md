# Sign with a signed timestamp

Generate a key pair.

```bash
export COSIGN_PASSWORD='sigstore-lab'
cosign generate-key-pair
```{{exec}}

Cosign reads the services to use from a **signing config**. Create one with the local Timestamp Authority only: no Fulcio, no Rekor.

```bash
cosign signing-config create \
  --tsa="url=http://localhost:3000/api/v1/timestamp,api-version=1,start-time=2024-01-01T00:00:00Z,operator=lab" \
  --tsa-config=ANY \
  --out signing-config.json
jq . signing-config.json
```{{exec}}

Cosign checks the timestamps it receives against a **trusted root**. Create one with the certificate chain of the local Timestamp Authority.

```bash
cosign trusted-root create \
  --tsa="url=http://localhost:3000/api/v1/timestamp,certificate-chain=tsa-chain.pem" \
  --out trusted-root.json
```{{exec}}

Sign a file.

```bash
echo "internal release 1.0.0" > release.txt
cosign sign-blob --yes --key cosign.key \
  --signing-config signing-config.json \
  --trusted-root trusted-root.json \
  --bundle release.sigstore.json \
  release.txt
jq '.verificationMaterial | keys' release.sigstore.json
```{{exec}}

The bundle holds a signed timestamp, and no transparency log entry. Nothing was published.
