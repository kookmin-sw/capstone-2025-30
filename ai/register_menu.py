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

def update_sign_language_description():

    menu_collection = db["menu"]

    descriptions = {
        # 당, 우유, 없다, 커피, 진하다, 쓰다
        "americano": "당, 우유, 커피, 진하다, 쓰다, 없다",
        # 우유, 넣다, 커피, 부드럽다
        "cafe_latte": "우유, 커피, 부드럽다, 넣다",
        # 달다, 향기, 우유, 커피, 부드럽다
        "vanilla_latte": "우유, 커피, 향기, 부드럽다, 달다",
        # 커피, 우유, 거품, 섞다, 커피, 부드럽다
        "cappuccino": "커피, 우유, 거품, 커피, 섞다, 부드럽다",
        # 초콜릿, 넣다, 커피, 달다, 진하다
        "cafe_mocha": "초콜릿, 커피, 진하다, 달다, 넣다",
        "chocolate_latte": "초콜릿, 우유, 넣다, 부드럽다, 달다",
        "lemon_tea": "레몬, 차, 시다",
        # 복숭아, 차, 달다, 향기
        "peach_tea": "복숭아, 차, 향기, 달다",
        "chamomile_tea": "꽃, 차, 부드럽다, 평화",
        # 꿀, 차, 달다, 부드럽다
        "honey_tea": "꿀, 차, 부드럽다, 달다",
        "milk_tea": "우유, 차, 넣다, 부드럽다",
        "lemon_ade": "레몬, 탄산, 마시다",
        "green_grape_ade": "청포도, 탄산, 마시다",
        # 빵, 재료, 사이, 넣다
        "sandwich": "빵, 사이, 재료, 넣다"
    }

    for name, desc in descriptions.items():
        menu_collection.update_one({"name": name}, {"$set": {"sign_language_description": desc}})

    print("모든 메뉴에 sign_language_description 필드가 추가되었습니다.")


# update_sign_language_description()

def register_sign_language_words():
    sign_language_collection = db["sign_language"]

    creds = Credentials.from_service_account_file(json_key_file, scopes=[
        "https://www.googleapis.com/auth/spreadsheets",
        "https://www.googleapis.com/auth/drive"
    ])
    gc = gspread.authorize(creds)
    spreadsheet_id = os.getenv("SPREADSHEET_ID")
    sheet = gc.open_by_key(spreadsheet_id).sheet1

    # 전체 행을 삽입하는 경우
    # data = sheet.get_all_records()
    # sign_language_collection.insert_many(data)

    headers = sheet.row_values(1)

    # 단일 행을 삽입하는 경우
    # row_new = sheet.row_values(71)

    # if row_new:
    #     data_new = dict(zip(headers, row_new))

    #     sign_language_collection.insert_one(data_new)

    # 여러 행을 삽입하는 경우
    rows_new = sheet.get(f"A72:Z74")  

    if rows_new:
        data_list = [dict(zip(headers, row)) for row in rows_new]  

        sign_language_collection.insert_many(data_list) 
    print("sign_language 데이터가 MongoDB에 삽입되었습니다.")


# register_sign_language_words()

def get_sign_language_url_list(menu):
    menu_collection = db["menu"]
    sign_language_collection = db["sign_language"]

    menu_data = menu_collection.find_one({"name": menu}, {"sign_language_description": 1})

    if not menu_data or "sign_language_description" not in menu_data:
        print(f"{menu} 메뉴에 대한 sign_language_description이 없습니다.")
        return []
    
    words = menu_data["sign_language_description"].split(", ")

    url_list = []
    for word in words:
        sign_data = sign_language_collection.find_one({"name": {"$regex": word}})

        if sign_data and "url" in sign_data:
            url_list.append(sign_data["url"])

    return url_list

# print(get_sign_language_url_list("americano"))