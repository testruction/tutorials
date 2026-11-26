![Sigstore logo](https://raw.githubusercontent.com/sigstore/community/main/artwork/sigstore/horizontal/color/sigstore_horizontal-color.svg)

[Cosign](https://docs.sigstore.dev/cosign/signing/overview/) is the command line of Sigstore. It signs and verifies files (*blobs*), container images and **attestations**: signed statements about an artifact, such as its SBOM or its provenance.

This lab uses a **key pair**, the classic way to sign. The next lab replaces the key pair by a short-lived certificate (*keyless* signing).

The environment provides a local OCI registry on `localhost:5000`, [crane](https://github.com/google/go-containerregistry/tree/main/cmd/crane) to copy images and [syft](https://github.com/anchore/syft) to generate SBOMs.

## Learning objectives

The objective of this lab is to learn how to:

1. Generate a key pair, sign and verify a file
2. Sign and verify a container image
3. Attach an SBOM attestation to an image and verify it
4. Add annotations to a signature and require them at verification

## References

* [Cosign: signing overview](https://docs.sigstore.dev/cosign/signing/overview/)
* [Cosign: verifying](https://docs.sigstore.dev/cosign/verifying/verify/)
* [in-toto attestations](https://github.com/in-toto/attestation)
