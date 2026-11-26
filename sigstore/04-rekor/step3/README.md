# Prove the inclusion

An **inclusion proof** is the list of hashes needed to recompute the root hash of the tree from the entry. Ask Rekor for one, and let `rekor-cli` recompute the root.

```bash
rekor-cli verify --log-index ${LOG_INDEX}
```{{exec}}

> The last lines compare the **computed** root hash with the **expected** one, signed by the log.

The bundle already contains an inclusion proof and a signed checkpoint, captured at signing time. This is why Cosign can verify a bundle without calling Rekor.

```bash
jq '.verificationMaterial.tlogEntries[0].inclusionProof | {logIndex, treeSize, hashes: (.hashes | length)}' artifact.sigstore.json
```{{exec}}

> `inclusionProof.logIndex` is the position in the current shard, while `logIndex` is the position in the whole log.

Finally, check the signature and the inclusion of the file in a single command.

```bash
jq -r '.messageSignature.signature' artifact.sigstore.json | base64 -d > artifact.sig
rekor-cli verify --artifact artifact.txt --signature artifact.sig --public-key cosign.pub --pki-format x509
```{{exec}}
