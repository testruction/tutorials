import time
from locust import HttpUser, task, between
import random


class LoadTesting(HttpUser):
    wait_time = between(1, 5)

    @task(3)
    def fakenames(self):
        skip = random.randrange(0, 10)
        limit = random.randrange(100, 500, 33)
        self.client.get(f"/v1/fakenames?skip={skip}&limit={limit}")
        # self.client.get("/v1/status/200")

    @task(1)
    def http_status_code(self):
        code = random.choice([200,
                              500,
                              501,
                              201,
                              502,
                              203,
                              503,
                              204,
                              504,
                              205,
                              505,
                              206,
                              506,
                              207,
                              507,
                              208,
                              508,
                              209,
                              509,
                              210,
                              510,
                              211,
                              511])
        # self.client.get("/v1/status/200")
        self.client.get(f"/v1/status/{code}")
        time.sleep(random.randrange(1, 7))
