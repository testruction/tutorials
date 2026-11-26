# Sign and verify a commit

Commit a file.

```bash
echo "# Demo" > README.md
git add README.md
git commit -m "Add README"
```{{exec}}

There is no browser in the lab: Gitsign prints a link to `https://oauth2.sigstore.dev`. Open it, sign in, copy the verification code, paste it in the terminal and press **Enter**.

Display the signature.

```bash
git log --show-signature -1
```{{exec}}

Git checks that the signature matches the commit and that the certificate chains to Fulcio. It does **not** check *who* signed. Gitsign does, against the identity and the issuer that you expect: replace them with yours (`https://github.com/login/oauth`, `https://accounts.google.com` or `https://login.microsoftonline.com`).

```bash
gitsign verify HEAD \
  --certificate-identity "$(git config user.email)" \
  --certificate-oidc-issuer https://github.com/login/oauth
```{{copy}}

Sign a tag the same way, and verify it.

```bash
git tag -m "First release" v1.0.0
git verify-tag v1.0.0
```{{exec}}

> `git verify-tag` and `git verify-commit` work, but warn that the certificate claims were not checked: prefer `gitsign verify` and `gitsign verify-tag`.

> Each signature needs a new certificate, so Gitsign asks you to sign in again. The [credential cache](https://github.com/sigstore/gitsign/blob/main/cmd/gitsign-credential-cache/README.md) keeps the ephemeral key and its certificate for their 10 minutes lifetime.
