# The Timestamp Authority

Check that the Timestamp Authority answers.

```bash
curl -s -o /dev/null -w '%{http_code}\n' http://localhost:3000/ping
```{{exec}}

Download its certificate chain: verifiers need it to trust the timestamps.

```bash
curl -s -o tsa-chain.pem http://localhost:3000/api/v1/timestamp/certchain
openssl crl2pkcs7 -nocrl -certfile tsa-chain.pem | openssl pkcs7 -print_certs -noout
```{{exec}}

The chain holds a root, an intermediate and a timestamping certificate. Only a certificate with the **Time Stamping** extended key usage may sign timestamps.

```bash
openssl x509 -in tsa-chain.pem -noout -subject -ext extendedKeyUsage
```{{exec}}
