# Congratulations

You added an entry to the public Rekor log, found it, and proved that it is included in the log.

## What was done

* Read the state of the log and checked its consistency.
* Searched entries by digest and by public key.
* Verified inclusion proofs from Rekor and from a Sigstore bundle.

## Going further

* [Rekor v2](https://blog.sigstore.dev/rekor-v2-ga/) is a tile-based log, cheaper to run and to mirror. Its shards already appear in the Sigstore trusted root.
* [rekor-monitor](https://github.com/sigstore/rekor-monitor) watches the log for your identities and keys, for example from a scheduled GitHub Actions workflow.
