# Configure Git

Create a repository.

```bash
git init demo
cd demo
```{{exec}}

Tell Git to sign every commit and tag with Gitsign, which produces X.509 (`x509`) signatures.

```bash
git config gpg.format x509
git config gpg.x509.program gitsign
git config commit.gpgsign true
git config tag.gpgsign true
```{{exec}}

> Add `--global` to these commands to sign in every repository.

Set your name and the email address of the account you will sign in with: GitHub, Google or Microsoft.

```bash
git config user.name "Your Name"
git config user.email "you@example.com"
```{{copy}}

Optionally, preselect the identity provider to skip the provider choice at each signature: `https://github.com/login/oauth`, `https://accounts.google.com` or `https://login.microsoftonline.com`.

```bash
git config gitsign.connectorID https://github.com/login/oauth
```{{copy}}
