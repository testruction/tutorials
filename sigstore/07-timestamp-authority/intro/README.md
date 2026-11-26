![Sigstore logo](https://raw.githubusercontent.com/sigstore/community/main/artwork/sigstore/horizontal/color/sigstore_horizontal-color.svg)

A signature made with a short-lived certificate is only valid if it was made while the certificate was valid. Rekor proves it with the time at which it recorded the entry. A **Timestamp Authority** (TSA) proves it without a transparency log: it signs the signature together with the current time, following [RFC 3161](https://www.rfc-editor.org/rfc/rfc3161).

Signed timestamps are useful when the transparency log cannot be used: private or air-gapped environments, or artifacts whose signature must not be public. The public Sigstore instance runs a TSA at `https://timestamp.sigstore.dev`, and Cosign 3 asks it for a timestamp by default.

The environment runs the [Sigstore Timestamp Authority](https://github.com/sigstore/timestamp-authority) on `localhost:3000`, with an in-memory signing key that is only fit for testing.

## Learning objectives

The objective of this lab is to learn how to:

1. Get the certificate chain of a Timestamp Authority
2. Sign a file with a signed timestamp and no transparency log
3. Verify a signed timestamp

## References

* [Sigstore Timestamp Authority](https://github.com/sigstore/timestamp-authority)
* [Cosign: timestamps](https://docs.sigstore.dev/cosign/verifying/timestamps/)
* [RFC 3161: Time-Stamp Protocol](https://www.rfc-editor.org/rfc/rfc3161)
