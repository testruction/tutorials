# The Sigstore services

Cosign is installed. Check its version.

```bash
cosign version
```{{exec}}

A Sigstore client needs two documents:

* A **signing config**, that lists the services used to sign: the OpenID Connect provider, Fulcio, Rekor and the Timestamp Authority.
* A **trusted root**, that holds the certificates and public keys used to verify what these services return.

Both are distributed with [The Update Framework (TUF)](https://theupdateframework.io), whose root of trust is embedded in the clients. Generate the signing config of the public Sigstore instance.

```bash
cosign signing-config create --with-default-services --out signing-config.json
jq -r '.oidcUrls[].url, .caUrls[].url, .rekorTlogUrls[].url, .tsaUrls[].url' signing-config.json
```{{exec}}

Service | URL | Role
--- | --- | ---
OpenID Connect | `https://oauth2.sigstore.dev/auth` | Authenticates the signer (Google, GitHub, Microsoft accounts)
Fulcio | `https://fulcio.sigstore.dev` | Issues a 10 minutes certificate for the authenticated identity
Rekor | `https://rekor.sigstore.dev` | Records the signature in a public transparency log
Timestamp Authority | `https://timestamp.sigstore.dev` | Signs the time of the signature

Generate the trusted root.

```bash
cosign trusted-root create --with-default-services --out trusted-root.json
jq -r '.certificateAuthorities[].uri, .tlogs[].baseUrl, .timestampAuthorities[].uri' trusted-root.json | sort -u
```{{exec}}

> **Notice**:
> The trusted root lists several Fulcio certificates and Rekor logs: keys rotate over time, and old signatures must stay verifiable. The `log2025-1.rekor.sigstore.dev` entry is a shard of [Rekor v2](https://blog.sigstore.dev/rekor-v2-ga/), the new tile-based log.
