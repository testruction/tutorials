# Verify the signed timestamp

Extract the timestamp from the bundle and read it.

```bash
jq -r '.verificationMaterial.timestampVerificationData.rfc3161Timestamps[0].signedTimestamp' release.sigstore.json | base64 -d > release.tsr
openssl ts -reply -in release.tsr -text | grep -E 'Status|Time stamp|TSA'
```{{exec}}

The Timestamp Authority did not see the file: it signed the digest of the **signature**.

```bash
openssl ts -reply -in release.tsr -text | sed -n '/Message data:/,/Serial/p'
jq -r '.messageSignature.signature' release.sigstore.json | base64 -d | sha256sum
```{{exec}}

Verify the file. `--use-signed-timestamps` requires a valid timestamp, and `--insecure-ignore-tlog` accepts that there is no transparency log entry.

```bash
cosign verify-blob --key cosign.pub \
  --bundle release.sigstore.json \
  --trusted-root trusted-root.json \
  --use-signed-timestamps \
  --insecure-ignore-tlog \
  release.txt
```{{exec}}

Without the local trusted root, Cosign uses the public Sigstore one, which does not know this Timestamp Authority.

```bash
cosign verify-blob --key cosign.pub \
  --bundle release.sigstore.json \
  --use-signed-timestamps \
  --insecure-ignore-tlog \
  release.txt
```{{exec}}

> **Notice**:
> With a key pair, the timestamp proves *when* the file was signed, which matters when the key is later revoked or leaked. With a Fulcio certificate, it proves that the signature was made during the 10 minutes of the certificate, like a Rekor entry does.
