# Read and verify the certificate

Extract the certificate from the bundle.

```bash
jq -r '.verificationMaterial.certificate.rawBytes' hello.sigstore.json | base64 -d > hello.crt
openssl x509 -in hello.crt -inform DER -noout -issuer -dates -ext subjectAltName
```{{exec}}

* The **issuer** is the Sigstore intermediate certificate authority.
* The **validity** is 10 minutes.
* The **subject alternative name** is the email address of your account.

Fulcio adds custom extensions under the `1.3.6.1.4.1.57264` OID. The `1.3.6.1.4.1.57264.1.1` extension holds the OpenID Connect issuer that authenticated you.

```bash
openssl x509 -in hello.crt -inform DER -noout -text | grep -A1 '1.3.6.1.4.1.57264.1.1:'
```{{exec}}

Store the identity and the issuer.

```bash
IDENTITY=$(openssl x509 -in hello.crt -inform DER -noout -ext subjectAltName | tail -1 | sed 's/.*email://')
ISSUER=$(openssl x509 -in hello.crt -inform DER -noout -text | grep -A1 '1.3.6.1.4.1.57264.1.1:' | tail -1 | tr -d ' ')
echo "${IDENTITY} authenticated by ${ISSUER}"
```{{exec}}

Verify the file. Both the identity and the issuer are required.

```bash
cosign verify-blob hello.txt \
  --bundle hello.sigstore.json \
  --certificate-identity "${IDENTITY}" \
  --certificate-oidc-issuer "${ISSUER}"
```{{exec}}

The certificate has expired, or will in a few minutes, and the verification still succeeds: Rekor proves that the signature was made while the certificate was valid.

Verify against another identity.

```bash
cosign verify-blob hello.txt \
  --bundle hello.sigstore.json \
  --certificate-identity someone@example.com \
  --certificate-oidc-issuer "${ISSUER}"
```{{exec}}
