from fastapi import FastAPI

app = FastAPI(
    title="CI/CD FastAPI Project",
    version="1.0.0"
)

@app.get("/")
def home():
    return {
        "message": "FastAPI deployed successfully!",
        "status": "running"
    }

@app.get("/users")
def get_users():
    return {
        "users": [
            {"id": 1, "name": "Jitendra"},
            {"id": 2, "name": "Rajesh"}
        ]
    }