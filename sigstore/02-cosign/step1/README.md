# Sign a file with a key pair

Cosign encrypts the private key with a password. In this lab, the password is read from the `COSIGN_PASSWORD` variable instead of a prompt.

```bash
export COSIGN_PASSWORD='sigstore-lab'
cosign generate-key-pair
ls cosign.*
```{{exec}}

> `cosign.key` is the encrypted private key, `cosign.pub` the public key to give to the users of your software.

Create a file and sign it. The signature, the public key hint and the transparency log proof are written in a **bundle**.

```bash
echo "release 1.0.0" > release.txt
cosign sign-blob --yes --key cosign.key --bundle release.sigstore.json release.txt
```{{exec}}

> **Notice**:
> Even with a key pair, Cosign records the signature in the public [Rekor](https://rekor.sigstore.dev) transparency log. The entry holds the digest of the file, the signature and the public key, never the file itself.

Verify the file.

```bash
cosign verify-blob --key cosign.pub --bundle release.sigstore.json release.txt
```{{exec}}

Modify the file and verify it again.

```bash
echo "release 1.0.1" > release.txt
cosign verify-blob --key cosign.pub --bundle release.sigstore.json release.txt
```{{exec}}
