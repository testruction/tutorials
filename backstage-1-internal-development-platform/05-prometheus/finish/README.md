# Generate traffic load on the backend

Open a new tab, then run the following command to generate some traffic to the backend component using [Locust](https://locust.io) and the `~/locustfile.py` script.

```bash
locust --autostart -f ~/locustfile.py --users 5 --spawn-rate 2 -H http://localhost:18180
```

Return to the Backstage console of the **backend** component to observe the prometheus behavior.

Use the following URL to observe the load generator execution.

* Locust UI [Click here]({{TRAFFIC_HOST1_8089}}).