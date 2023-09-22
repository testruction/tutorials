import time
from locust import HttpUser, task, between
import random


class QuickstartUser(HttpUser):
    wait_time = between(1, 5)

    @task
    def fakenames(self):
        skip = random.randrange(0, 10)
        limit = random.randrange(200, 210)
        self.client.get(f"/v1/fakenames?skip={skip}&limit={limit}")

    @task(3)
    def get(self):
        code = random.randrange(500, 511)
        self.client.get("/v1/status/200")
        self.client.get(f"/v1/status/{code}")
        time.sleep(1)
