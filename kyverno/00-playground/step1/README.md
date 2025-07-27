# Environment

![architecture](https://main.kyverno.io/images/kyverno-architecture.png)

Use the following command to generate some workload.

```bash
kubectl apply -f ~/malicious-nginx.yaml
```{{exec}}

Application | URL
--- | ---
Policy reporter | [Click here]({{TRAFFIC_HOST1_8081}})
Prometheus | [Click here]({{TRAFFIC_HOST1_9090}})
Grafana | [Click here]({{TRAFFIC_HOST1_80}})
Jaeger _under contruction_ | [Click here]()
