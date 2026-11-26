![Sigstore logo](https://raw.githubusercontent.com/sigstore/community/main/artwork/sigstore/horizontal/color/sigstore_horizontal-color.svg)

[Fulcio](https://docs.sigstore.dev/certificate_authority/overview/) is the certificate authority of Sigstore. Instead of a long-lived key pair, the signer proves its identity with **OpenID Connect** (a Google, GitHub or Microsoft account, or the workload identity of a CI job), and Fulcio issues a certificate for this identity that is valid for **10 minutes**.

Cosign generates a key pair in memory, gets the certificate, signs, and throws the private key away. This is called **keyless signing**. The verifier no longer needs your public key: it needs your **identity** and the **issuer** that authenticated it.

> **Warning**:
> The first step signs with your own account. The email address of the account is written in the certificate and in the **public** Rekor transparency log, and cannot be removed. Skip to step 3 if you do not want this.

## Learning objectives

The objective of this lab is to learn how to:

1. Sign a file with an OpenID Connect identity
2. Read the identity and the issuer in a Fulcio certificate, and verify a signature against them
3. Verify signatures made by a CI workflow

## References

* [Fulcio overview](https://docs.sigstore.dev/certificate_authority/overview/)
* [Fulcio certificate extensions (OIDs)](https://github.com/sigstore/fulcio/blob/main/docs/oid-info.md)
* [Cosign: keyless verification](https://docs.sigstore.dev/cosign/verifying/verify/#keyless-verification-using-openid-connect)
