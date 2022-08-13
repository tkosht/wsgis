import json
import falcon


class Resource(object):
    def on_get(self, req, resp):
        doc = {"message": "hello world!!"}
        resp.body = json.dumps(doc, ensure_ascii=False)
        resp.status = falcon.HTTP_200


api = application = falcon.API()
api.add_route("/hello", Resource())

