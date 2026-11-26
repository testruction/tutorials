# Search and inspect entries

Search the log by the digest of the file.

```bash
rekor-cli search --sha $(sha256sum artifact.txt | cut -d ' ' -f 1)
```{{exec}}

> The search index is updated a few seconds after the entry is added. If no entry is found, run the command again.

Search the log by public key. A signer can run this search regularly to detect signatures made with a stolen key.

```bash
rekor-cli search --public-key cosign.pub --pki-format x509
```{{exec}}

Get the entry.

```bash
rekor-cli get --log-index ${LOG_INDEX} --format json | jq '{LogIndex, IntegratedTime, UUID}'
date -d @$(rekor-cli get --log-index ${LOG_INDEX} --format json | jq -r '.IntegratedTime')
```{{exec}}

`IntegratedTime` is when Rekor added the entry. It is the time that verifiers trust to check that a short-lived Fulcio certificate was valid when the signature was made.

The body of the entry is a `hashedrekord`: the digest of the file, the signature and the public key (or the certificate). The file itself is never uploaded.

```bash
rekor-cli get --log-index ${LOG_INDEX} --format json \
  | jq '.Body.HashedRekordObj | {digest: .data.hash.value, signer: (.signature.publicKey.content | @base64d)}'
cat cosign.pub
```{{exec}}
