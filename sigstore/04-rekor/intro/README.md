![Sigstore logo](https://raw.githubusercontent.com/sigstore/community/main/artwork/sigstore/horizontal/color/sigstore_horizontal-color.svg)

[Rekor](https://docs.sigstore.dev/logging/overview/) is the transparency log of Sigstore. It records signatures in an append-only [Merkle tree](https://transparency.dev/verifiable-data-structures/): an entry can be added, never modified or removed, and anyone can prove that an entry is in the log, and that the log was not rewritten.

Transparency serves two audiences:

* **Verifiers** check that a signature is recorded, which proves *when* it was made, and that a signer cannot deny it.
* **Signers** monitor the log for entries made with their identity or key, and detect a stolen identity or key.

## Learning objectives

The objective of this lab is to learn how to:

1. Read the state of the public Rekor log, and add an entry to it
2. Search and inspect entries
3. Verify the inclusion of an entry and the consistency of the log

## References

* [Rekor overview](https://docs.sigstore.dev/logging/overview/)
* [rekor-cli](https://docs.sigstore.dev/logging/CLI/)
* [Transparency.dev: verifiable data structures](https://transparency.dev/verifiable-data-structures/)
