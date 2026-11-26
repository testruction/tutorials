# Sign with your identity

Create a file and sign it without `--key`.

```bash
echo "hello sigstore" > hello.txt
cosign sign-blob --bundle hello.sigstore.json hello.txt
```{{exec}}

1. Cosign displays the terms of use of the public instance, then asks for confirmation: type `y`.
2. There is no browser in the lab, so Cosign prints a link to `https://oauth2.sigstore.dev`. Open it in your browser.
3. Sign in with a GitHub, Google or Microsoft account.
4. Copy the verification code shown by the page, paste it in the terminal and press **Enter**.

Cosign then:

* sends a proof of possession of its ephemeral key and your OpenID Connect token to Fulcio, which returns a certificate,
* signs the file,
* records the signature and the certificate in Rekor,
* writes everything in `hello.sigstore.json`.

```bash
jq '.verificationMaterial | keys' hello.sigstore.json
```{{exec}}
