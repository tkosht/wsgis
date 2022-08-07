from fastapi import FastAPI


app = FastAPI()


@app.get('/hello')
async def hello():
    doc = {"message": "hello world!!"}
    return doc

