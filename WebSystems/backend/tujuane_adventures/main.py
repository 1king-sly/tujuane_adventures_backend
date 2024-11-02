from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}


SECRET_KEY ="4a443777b8ed4c99d52031d926d6eff35d2d05d90cd768a48828e6e357396a5a"