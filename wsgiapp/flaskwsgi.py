import json
from flask import Flask

api = Flask(__name__)


@api.route("/hello")
def hello():
    doc = {"message": "hello world!!"}
    return json.dumps(doc, ensure_ascii=False)  # body
