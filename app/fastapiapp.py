from fastapi import FastAPI


api = FastAPI()


@api.get('/hello')
async def hello():
    doc = {"message": "hello world!!"}
    return doc

