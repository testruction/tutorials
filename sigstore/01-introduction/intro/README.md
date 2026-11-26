![Sigstore logo](https://raw.githubusercontent.com/sigstore/community/main/artwork/sigstore/horizontal/color/sigstore_horizontal-color.svg)

[Sigstore](https://www.sigstore.dev) is an open source project of the [OpenSSF](https://openssf.org) to sign and verify software: files, container images, Git commits, SBOMs and other attestations.

Signing software is old news, but managing signing keys is hard: they leak, expire, get lost, and the users of the software rarely know which key to trust. Sigstore removes most of this burden:

* **Cosign** signs and verifies artifacts.
* **Fulcio** is a certificate authority that issues short-lived certificates bound to an OpenID Connect identity (an email address, a CI workflow...), so signers do not keep long-lived keys.
* **Rekor** is a public, append-only transparency log that records every signature, so anyone can audit what was signed, by whom and when.
* A **Timestamp Authority** (TSA) proves when a signature was made.
* The **Policy Controller** and **Gitsign** apply Sigstore to Kubernetes admission and to Git.

## Learning objectives

The objective of this lab is to learn how to:

1. List the Sigstore public services and the trust root that clients use to verify them
2. Verify a software release signed with Sigstore
3. Read the content of a Sigstore bundle

## References

* [Sigstore documentation](https://docs.sigstore.dev)
* [Securing Your Software Supply Chain with Sigstore (LFS182)](https://training.linuxfoundation.org/training/securing-your-software-supply-chain-with-sigstore-lfs182/), the course this track follows
