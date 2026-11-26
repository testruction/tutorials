# Congratulations

You signed without managing a key, and verified signatures against identities instead of public keys.

## What was done

* Signed a file with an OpenID Connect identity and a 10 minutes Fulcio certificate.
* Read the identity, the issuer and the CI extensions of a certificate.
* Verified signatures with exact and regular expression identities, and with CI details.

## Going further

* In GitHub Actions, give the job the `id-token: write` permission and run `cosign sign` without any flag: Cosign detects the ambient OpenID Connect token.
* The next lab explains how **Rekor** keeps these short-lived signatures verifiable.
