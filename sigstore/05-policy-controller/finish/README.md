# Congratulations

Your cluster now only runs the images that you signed.

## What was done

* Enabled the Policy Controller in a namespace.
* Required a signature made with a key, and rejected an unsigned image.
* Ran a policy in warn mode.
* Wrote a keyless policy that trusts an identity.

## Going further

* Policies can also require **attestations** (an SBOM, a vulnerability scan, a SLSA provenance) and check their content with [CUE or Rego](https://docs.sigstore.dev/policy-controller/overview/#policy-attestations).
* [Kyverno](https://kyverno.io) also verifies Sigstore signatures, with its `verifyImages` rules.
