from fastapi import FastAPI, Query, HTTPException
from starlette.config import Config
from dotenv import load_dotenv
from pymongo import MongoClient
from typing import List

config = Config('.env')
mongo_db_url = config('MONGO_DB_URL')
json_key_file = config("SPREADSHEET_JSON_KEY")
client = MongoClient(mongo_db_url)
db = client["dev"]

app = FastAPI()


@app.get("/", response_model=List[str])
def get_sign_language_url_list(menu: str = Query(..., description="메뉴 이름")):
    menu_collection = db["menu"]
    sign_language_collection = db["sign_language"]

    menu_data = menu_collection.find_one({"name": menu}, {"sign_language_description": 1})

    if not menu_data or "sign_language_description" not in menu_data:
        raise HTTPException(status_code=404, detail=f"{menu} 메뉴에 대한 sign_language_description이 없습니다.")

    words = menu_data["sign_language_description"].split(", ")

    url_list = []
    for word in words:
        sign_data = sign_language_collection.find_one({"name": {"$regex": word}})

        if sign_data and "url" in sign_data:
            url_list.append(sign_data["url"])

    return url_list
