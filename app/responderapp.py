import json
import responder

api = responder.API()


@api.route("/hello")
async def hello(req, resp):
    doc = {"message": "hello world!!"}
    resp.text = json.dumps(doc, ensure_ascii=False)
