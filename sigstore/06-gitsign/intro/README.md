![Sigstore logo](https://raw.githubusercontent.com/sigstore/community/main/artwork/sigstore/horizontal/color/sigstore_horizontal-color.svg)

Anyone can write any name and email address in a Git commit. Signed commits prove who wrote them, but GPG and SSH signing keys must be generated, protected, published and rotated by every developer.

[Gitsign](https://github.com/sigstore/gitsign) signs commits and tags with a short-lived Fulcio certificate bound to your OpenID Connect identity, and records the signature in Rekor. Git calls it like it calls `gpg`.

> **Warning**:
> This lab signs with your own account. Your email address is written in the certificate, in the commits, and in the **public** Rekor transparency log, and cannot be removed.

## Learning objectives

The objective of this lab is to learn how to:

1. Configure Git to sign with Gitsign
2. Sign and verify a commit and a tag
3. Read the certificate stored in a commit

## References

* [Gitsign repository](https://github.com/sigstore/gitsign)
* [Gitsign verification](https://github.com/sigstore/gitsign#verifying-commits)
