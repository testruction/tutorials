# Signatures made by a CI workflow

In a CI system, the identity is the **workflow** itself. GitHub Actions, GitLab CI, Buildkite and others provide an OpenID Connect token to their jobs, and Fulcio writes the details of the run in the certificate.

The gitsign release was signed by a GitHub Actions workflow. Download it with its bundle.

```bash
curl -fsSL -o gitsign https://github.com/sigstore/gitsign/releases/download/v0.18.0/gitsign_0.18.0_linux_amd64
curl -fsSL -o gitsign.bundle https://github.com/sigstore/gitsign/releases/download/v0.18.0/gitsign_0.18.0_linux_amd64.bundle
jq -r '.verificationMaterial.certificate.rawBytes' gitsign.bundle | base64 -d > gitsign.crt
```{{exec}}

Display the extensions that describe the run.

```bash
openssl x509 -in gitsign.crt -inform DER -noout -text \
  | grep -A1 -E '1\.3\.6\.1\.4\.1\.57264\.1\.(8|9|12|14|20|21):'
```{{exec}}

> `openssl` does not know these extensions: it prints their raw value, preceded by one or two characters that encode its type and length.

OID | Name | Value
--- | --- | ---
`1.3.6.1.4.1.57264.1.8` | Issuer | `https://token.actions.githubusercontent.com`
`1.3.6.1.4.1.57264.1.9` | Build signer URI | The workflow file and the ref it ran on
`1.3.6.1.4.1.57264.1.12` | Source repository URI | `https://github.com/sigstore/gitsign`
`1.3.6.1.4.1.57264.1.14` | Source repository ref | `refs/tags/v0.18.0`
`1.3.6.1.4.1.57264.1.20` | Build trigger | `push`
`1.3.6.1.4.1.57264.1.21` | Run invocation URI | The link to the run

A verification can match any release tag with a regular expression, and also require details of the run.

```bash
cosign verify-blob gitsign \
  --bundle gitsign.bundle \
  --certificate-identity-regexp '^https://github\.com/sigstore/gitsign/\.github/workflows/release\.yml@refs/tags/' \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  --certificate-github-workflow-repository sigstore/gitsign \
  --certificate-github-workflow-trigger push
```{{exec}}

Require a release built from a pull request.

```bash
cosign verify-blob gitsign \
  --bundle gitsign.bundle \
  --certificate-identity-regexp '^https://github\.com/sigstore/gitsign/' \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  --certificate-github-workflow-trigger pull_request
```{{exec}}

> Always anchor the regular expressions (`^...`) and escape the dots: `--certificate-identity-regexp 'github.com/sigstore'` would also match `https://github.com/attacker/github.com/sigstore`.
