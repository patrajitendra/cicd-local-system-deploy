from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_home():
    response = client.get("/")

    assert response.status_code == 200

    assert response.json()["status"] == "running"

def test_users():
    response = client.get("/users")

    assert response.status_code == 200

    assert len(response.json()["users"]) == 2