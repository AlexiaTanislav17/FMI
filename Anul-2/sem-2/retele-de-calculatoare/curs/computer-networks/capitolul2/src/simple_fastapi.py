from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn

class Item(BaseModel):
    value: int

app = FastAPI()

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/items/{item_id}")
async def read_item(item_id):
    return {"item_id": item_id}

@app.post("/")
async def create_item(item: Item):
    return {"received_value": item.value}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)