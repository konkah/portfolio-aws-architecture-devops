import time
import threading

from fastapi import FastAPI


app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello, moto!"}

@app.get("/cpu-burn")
def burn_cpu():
    def stress_cpu():
        end_time = time.time() + 60
        while time.time() < end_time:
            _ = sum(i * i for i in range(10000))

    for _ in range(4):
        thread = threading.Thread(target=stress_cpu)
        thread.start()

    return {"status": "CPU stress test started"}
