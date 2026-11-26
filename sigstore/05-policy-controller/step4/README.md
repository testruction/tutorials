# Warn mode and keyless policies

Before enforcing a new policy, run it in **warn** mode: the pods are admitted, and the result of the verification is returned as a warning.

```bash
kubectl patch clusterimagepolicy signed-by-lab-key --type=merge -p '{"spec":{"mode":"warn"}}'
kubectl -n demo run unsigned --image=${UNSIGNED} -- sleep 3600
```{{exec}}

## Optional: require your identity

A keyless policy trusts an **identity** instead of a key. This part signs with your own account: your email address is written in the public Rekor log.

Delete the pod, set the key policy back to `enforce`, and limit it to the signed image.

```bash
kubectl -n demo delete pod unsigned
kubectl patch clusterimagepolicy signed-by-lab-key --type=merge \
  -p '{"spec":{"mode":"enforce","images":[{"glob":"ttl.sh/**-signed*"}]}}'
```{{exec}}

Sign the other image with your identity: follow the link and paste the verification code (see the Fulcio lab).

```bash
cosign sign ${UNSIGNED}
```{{exec}}

Write a policy for the other image. Replace the email address and the issuer with yours: `https://github.com/login/oauth`, `https://accounts.google.com` or `https://login.microsoftonline.com`.

```bash
cat > keyless-policy.yaml <<'EOF'
apiVersion: policy.sigstore.dev/v1beta1
kind: ClusterImagePolicy
metadata:
  name: signed-by-me
spec:
  images:
    - glob: "ttl.sh/**-unsigned*"
  authorities:
    - name: me
      # Keyless signatures of Cosign 3 are stored as Sigstore bundles
      signatureFormat: bundle
      keyless:
        url: https://fulcio.sigstore.dev
        identities:
          - issuer: https://github.com/login/oauth
            subject: me@example.com
EOF
```{{copy}}

Apply the policy and run the image again.

```bash
kubectl apply -f keyless-policy.yaml
kubectl -n demo run unsigned --image=${UNSIGNED} -- sleep 3600
```{{exec}}

> When several policies match an image, the image must satisfy **all** of them.
