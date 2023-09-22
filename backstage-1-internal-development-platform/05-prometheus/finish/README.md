# Generate traffic load on the backend

Open a new terminal tab, then run the following command to generate some traffic to the backend component using [Locust](https://locust.io) and the `~/locustfile.py` script.

```bash
locust --autostart -f ~/locustfile.py --users 5 --spawn-rate 2 -H http://localhost:18180
```

Return to the Backstage console of the **backend** component to observe the prometheus behavior.

Use the following URLs to observe the load generator execution.

* **Locust UI** [Click here]({{TRAFFIC_HOST1_8089}})
* **Backstage application** [Click here]({{TRAFFIC_HOST1_3000}}) .
* Prometheus [Click here]({{TRAFFIC_HOST1_9090}}).
* Sample App API doc [Click here]({{TRAFFIC_HOST1_18180}}/v1/docs).
