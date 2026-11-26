# Inside a signed commit

The signature is stored in the `gpgsig` header of the commit object.

```bash
git cat-file commit HEAD
```{{exec}}

It is a detached PKCS #7 signature that embeds the Fulcio certificate. Extract the certificate.

```bash
git cat-file commit HEAD \
  | sed -n '/BEGIN SIGNED MESSAGE/,/END SIGNED MESSAGE/p' \
  | sed -e 's/^gpgsig //' -e 's/^ //' -e 's/SIGNED MESSAGE/PKCS7/' \
  | openssl pkcs7 -print_certs \
  | openssl x509 -noout -issuer -dates -ext subjectAltName
```{{exec}}

The certificate names your email address, and was valid for 10 minutes. The commit stays verifiable after its expiry, because Rekor recorded the signature while the certificate was valid.

> **Notice**:
> GitHub does not trust the Sigstore certificate authority, and displays Gitsign commits as **Unverified**. Run `gitsign verify` in CI to check them.
