# The public log

Display the state of the public Rekor instance.

```bash
rekor-cli loginfo
```{{exec}}

* **Total tree size** is the number of entries ever recorded.
* **Root hash** sums up the whole tree: changing any entry would change it.
* The log is split in **shards**: when a tree grows too large, a new one is started. *Active tree size* counts the entries of the current shard.

`rekor-cli` saved this state in `~/.rekor/state.json`. The next call checks that the new tree **extends** the saved one, which proves that no entry was removed or modified in between.

```bash
rekor-cli loginfo
```{{exec}}

Add an entry: sign a file with a new key pair.

```bash
export COSIGN_PASSWORD='sigstore-lab'
cosign generate-key-pair
echo "rekor lab $(date +%s)" > artifact.txt
cosign sign-blob --yes --key cosign.key --bundle artifact.sigstore.json artifact.txt
```{{exec}}

The bundle holds the position of the entry in the log.

```bash
LOG_INDEX=$(jq -r '.verificationMaterial.tlogEntries[0].logIndex' artifact.sigstore.json)
echo ${LOG_INDEX}
```{{exec}}
