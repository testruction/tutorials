# Congratulations

You signed a commit and a tag without any key to manage.

## What was done

* Configured Git to sign commits and tags with Gitsign.
* Verified a commit against your identity with `gitsign verify`.
* Extracted the Fulcio certificate from a commit.

## Going further

* Sign with the GitHub Actions identity: Gitsign detects the OpenID Connect token of the job, like Cosign.
* Sign SSH-free and GPG-free release tags, and verify them in the release workflow before publishing.
