![Sigstore logo](https://raw.githubusercontent.com/sigstore/community/main/artwork/sigstore/horizontal/color/sigstore_horizontal-color.svg)

Signing images is only useful if someone checks the signatures before running them. The [Policy Controller](https://docs.sigstore.dev/policy-controller/overview/) is a Kubernetes admission webhook that verifies the signatures and attestations of every image of a pod, against **ClusterImagePolicy** resources, and rejects the pods that do not comply.

The environment provides a Kubernetes cluster with the Policy Controller (installed with Helm in the `cosign-system` namespace), Cosign and [crane](https://github.com/google/go-containerregistry/tree/main/cmd/crane). The images are pushed to [ttl.sh](https://ttl.sh), an anonymous registry that deletes them after one hour.

## Learning objectives

The objective of this lab is to learn how to:

1. Enable the Policy Controller in a namespace
2. Write a ClusterImagePolicy that requires a signature made with a key
3. Reject unsigned images, or only warn about them
4. Require a signature made with an OpenID Connect identity

## References

* [Policy Controller overview](https://docs.sigstore.dev/policy-controller/overview/)
* [ClusterImagePolicy reference](https://docs.sigstore.dev/policy-controller/overview/#configuring-image-policies)
