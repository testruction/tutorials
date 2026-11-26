# Inside a Sigstore bundle

A bundle is a JSON document. List its parts.

```bash
jq '.verificationMaterial | keys' gitsign.bundle
```{{exec}}

Part | Content
--- | ---
`certificate` | The certificate issued by Fulcio to the signer
`tlogEntries` | The proof that the signature is recorded in Rekor
`timestampVerificationData` | Signed timestamps, when a Timestamp Authority was used

The signature itself is in `messageSignature`, next to the digest of the signed file, encoded in base64.

```bash
jq '.messageSignature.messageDigest' gitsign.bundle
openssl dgst -sha256 -binary gitsign | base64
```{{exec}}

Display the identity written in the certificate.

```bash
jq -r '.verificationMaterial.certificate.rawBytes' gitsign.bundle | base64 -d > gitsign.crt
openssl x509 -in gitsign.crt -inform DER -noout -issuer -dates -ext subjectAltName
```{{exec}}

> The certificate was valid for **10 minutes** only. The signature stays verifiable after its expiry, because Rekor proves that it was made during these 10 minutes.

Finally, change one byte of the binary and verify it again.

```bash
printf 'x' | dd of=gitsign bs=1 seek=1000 conv=notrunc 2> /dev/null
cosign verify-blob gitsign \
  --bundle gitsign.bundle \
  --certificate-identity https://github.com/sigstore/gitsign/.github/workflows/release.yml@refs/tags/v0.18.0 \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com
```{{exec}}
