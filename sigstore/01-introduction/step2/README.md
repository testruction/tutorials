# Verify a software release

The Sigstore tools sign their own releases. The [gitsign](https://github.com/sigstore/gitsign/releases) release ships each binary with a `.bundle` file, a **Sigstore bundle** that holds everything needed to verify the signature.

Download the binary and its bundle.

```bash
curl -fsSL -o gitsign https://github.com/sigstore/gitsign/releases/download/v0.18.0/gitsign_0.18.0_linux_amd64
curl -fsSL -o gitsign.bundle https://github.com/sigstore/gitsign/releases/download/v0.18.0/gitsign_0.18.0_linux_amd64.bundle
```{{exec}}

The release was signed by a GitHub Actions workflow, without any long-lived key. To verify it, you state **who** must have signed it: the identity of the workflow and the OpenID Connect issuer that vouched for it.

```bash
cosign verify-blob gitsign \
  --bundle gitsign.bundle \
  --certificate-identity https://github.com/sigstore/gitsign/.github/workflows/release.yml@refs/tags/v0.18.0 \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com
```{{exec}}

Cosign checked that:

1. The signature matches the content of the file.
2. The certificate was issued by Fulcio, and names the expected workflow and issuer.
3. The signature is recorded in Rekor, and was made while the certificate was valid.

Now pretend that you expect the binary to be built by another workflow.

```bash
cosign verify-blob gitsign \
  --bundle gitsign.bundle \
  --certificate-identity https://github.com/attacker/gitsign/.github/workflows/release.yml@refs/tags/v0.18.0 \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com
```{{exec}}

The verification fails: a valid signature is not enough, it must come from the identity you trust.
