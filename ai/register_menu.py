import os
from dotenv import load_dotenv
from pymongo import MongoClient
import gspread
from google.oauth2.service_account import Credentials
from google.auth import default

load_dotenv()
mongo_db_url = os.getenv("MONGO_DB_URL")
client = MongoClient(mongo_db_url)
db = client["dev"]
json_key_file = os.getenv("SPREADSHEET_JSON_KEY")

def register_menu():

    menu_collection = db["menu"]

    menu_collection.insert_one({
        "name": "americano",
        "description": "설탕이나 우유 없이 마시는, 진하고 쓴맛이 특징인 커피",
        "category": "coffee",
        "price": 4000
    })
    menu_collection.insert_one({
        "name": "cafe_latte",
        "description": "우유가 들어가 커피 맛이 부드러워진 커피",
        "category": "coffee",
        "price": 5000
    })
    menu_collection.insert_one({
        "name": "vanilla_latte",
        "description": "바닐라가 들어가 커피 맛이 달고 부드러워진 커피",
        "category": "coffee",
        "price": 5500
    })
    menu_collection.insert_one({
        "name": "cappuccino",
        "description": "우유 거품이 풍부한 커피로, 에스프레소와 우유 거품이 섞인 커피",
        "category": "coffee",
        "price": 5500
    })
    menu_collection.insert_one({
        "name": "cafe_mocha",
        "description": "초콜릿 시럽이 들어가 커피 맛이 달고 진한 커피",
        "category": "coffee",
        "price": 6000
    })
    menu_collection.insert_one({
        "name": "chocolate_latte",
        "description": "초콜릿과 우유가 섞여 부드럽고 달콤한 맛을 내는 음료",
        "category": "coffee",
        "price": 6000
    })
    menu_collection.insert_one({
        "name": "lemon_tea",
        "description": "레몬이 들어가 상큼하고 시원한 맛을 느낄 수 있는 차",
        "category": "tea",
        "price": 4500
    })
    menu_collection.insert_one({
        "name": "peach_tea",
        "description": "복숭아 향과 맛이 나는 달콤하고 향긋한 차",
        "category": "tea",
        "price": 4500
    })
    menu_collection.insert_one({
        "name": "chamomile_tea",
        "description": "캐모마일 꽃에서 우려낸 차로, 진정 효과가 있는 부드럽고 달콤한 맛의 차",
        "category": "tea",
        "price": 5000
    })
    menu_collection.insert_one({
        "name": "honey_tea",
        "description": "꿀이 들어가 달콤하고 부드러운 맛을 지닌 차",
        "category": "tea",
        "price": 5000
    })
    menu_collection.insert_one({
        "name": "milk_tea",
        "description": "우유가 들어가 차의 맛을 부드럽고 고소하게 만들어주는 음료",
        "category": "tea",
        "price": 5500
    })
    menu_collection.insert_one({
        "name": "lemon_ade",
        "description": "레몬과 탄산이 섞여 시원하고 상쾌한 맛이 나는 음료",
        "category": "non_coffee",
        "price": 5500
    })
    menu_collection.insert_one({
        "name": "green_grape_ade",
        "description": "청포도의 상큼한 맛과 탄산이 섞여 시원하고 달콤한 맛이 나는 음료",
        "category": "non_coffee",
        "price": 5500
    })
    menu_collection.insert_one({
        "name": "sandwich",
        "description": "여러 가지 재료를 빵 사이에 넣어 만든 음식",
        "category": "bread",
        "price": 6500
    })
    print("menu 컬렉션이 생성되었습니다.")


def register_sign_language_words():
    sign_language_collection = db["sign_language"]

    creds = Credentials.from_service_account_file(json_key_file, scopes=[
        "https://www.googleapis.com/auth/spreadsheets",
        "https://www.googleapis.com/auth/drive"
    ])
    gc = gspread.authorize(creds)
    spreadsheet_id = os.getenv("SPREADSHEET_ID")
    sheet = gc.open_by_key(spreadsheet_id).sheet1

    data = sheet.get_all_records()
    sign_language_collection.insert_many(data)
    print("sign_language 데이터가 MongoDB에 삽입되었습니다.")


# register_sign_language_words()
