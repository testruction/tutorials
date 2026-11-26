# Congratulations

You signed and verified a file, a container image and an SBOM attestation with Cosign.

## What was done

* Generated an encrypted key pair.
* Signed a file into a Sigstore bundle and detected a modification.
* Signed an image by digest, and listed its signature and attestation with `cosign tree`.
* Required annotations at verification.

## Going further

A key pair must be stored, rotated and distributed. Cosign also supports keys in a KMS (`awskms://`, `gcpkms://`, `azurekms://`, `hashivault://`) and in Kubernetes secrets (`k8s://`). The next lab removes the key altogether with **Fulcio**.
