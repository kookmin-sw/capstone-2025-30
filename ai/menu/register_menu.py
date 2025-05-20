import os
from dotenv import load_dotenv
from pymongo import MongoClient
import gspread
from google.oauth2.service_account import Credentials
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload
import requests
import mimetypes
import boto3
import urllib.parse

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
        "description": "고소하고 은은한 단맛과 균형잡힌 밸런스가 특징",
        "category": "coffee",
        "price": 4000,
    })
    menu_collection.insert_one({
        "name": "cafe_latte",
        "description": "고소한 에스프레소와 부드러운 우유가 어우러진 커피음료",
        "category": "coffee",
        "price": 4500
    })
    menu_collection.insert_one({
        "name": "wild_dry_cappuccino",
        "description": "풍부한 우유 거품에 시나몬슈가의 향으로 마무리한 커피음료",
        "category": "coffee",
        "price": 4500
    })
    menu_collection.insert_one({
        "name": "roasted_almond_latte",
        "description": "고소한 아몬드향과 달콤함이 어우러진 커피음료",
        "category": "coffee",
        "price": 5000
    })
    menu_collection.insert_one({
        "name": "muscovado_latte",
        "description": "유기농 사탕수수당을 사용한 특별한 숙성밀크와 커피를 배합한 고소하고 묵직한 카페라떼",
        "category": "coffee",
        "price": 5000
    })
    menu_collection.insert_one({
        "name": "brown_sugar_macchiato",
        "description": "고유의 깊은 풍미를 가진 대만산 브라운 슈가가 드리즐 된 달콤한 커피",
        "category": "coffee",
        "price": 5000
    })
    menu_collection.insert_one({
        "name": "jeju_green_oat_latte",
        "description": "어린찻잎으로 만든 제주산 최고급 말차와 귀리우유를 배합한 고소하고 진한 말차라떼",
        "category": "beverage",
        "price": 5000
    })
    menu_collection.insert_one({
        "name": "sweet_coffee",
        "description": "비정제 설탕으로 만든 베이스에 올라간 하겐다즈 아이스크림은 마음이 저축됨을 표현하였으며 커피와 만나 사르르 녹는 달콤함으로 마무리 됩니다.",
        "category": "signature",
        "price": 6500
    })
    menu_collection.insert_one({
        "name": "piggybank_choco_latte",
        "description": "어렷을 적 나만의 금고였던 돼지 저금통의 감성을 동전 초콜릿으로 표현한 감성적 음료입니다.",
        "category": "signature",
        "price": 6000
    })
    menu_collection.insert_one({
        "name": "bank_schpanner",
        "description": "달콤하고 쫀득한 생크림이 올라간 아인슈페너로서 잠시의 휴식이 필요한 순간 은행도 카페가 됩니다.",
        "category": "signature",
        "price": 5500
    })
    menu_collection.insert_one({
        "name": "elderflower_ade",
        "description": "엘더플라워의 은은한 향이 느껴지는 식용꽃으로 장식한 청량한 에이드",
        "category": "ice_drinks",
        "price": 5500
    })
    menu_collection.insert_one({
        "name": "passion_berry_ade",
        "description": "상큼한 라즈베리와 달콤한 블루베리 베이스의 청량한 에이드",
        "category": "ice_drinks",
        "price": 5500
    })
    menu_collection.insert_one({
        "name": "cafe_coco_and_shot_smoothie",
        "description": "달콤한 코코넛 블렌디드에 스윗의 에스프레소를 플로팅한 커피 스무디",
        "category": "ice_drinks",
        "price": 5500
    })
    menu_collection.insert_one({
        "name": "plain_yogurt_smoothie",
        "description": "달콤한 요거트 맛이 풍부한 부드러운 블렌디드 음료",
        "category": "ice_drinks",
        "price": 5500
    })
    menu_collection.insert_one({
        "name": "berry_yogurt_smoothie",
        "description": "상큼한 라즈베리와 달콤한 블루베리 베이스를 이용한 요거트 블렌디드 음료",
        "category": "ice_drinks",
        "price": 5500
    })
    menu_collection.insert_one({
        "name": "verveine_orange_mint",
        "description": "버베나, 오렌지, 민트가 부드럽게 블렌딩된 섬세한 허브 블렌딩 티",
        "category": "tea",
        "price": 4500
    })
    menu_collection.insert_one({
        "name": "rooibos_de_vanille",
        "description": "프리미엄 루이보스에 바닐라와 아몬드가 더해져 달콤하면서 포근한 느낌을 주는 논카페인 티",
        "category": "tea",
        "price": 4500
    })
    menu_collection.insert_one({
        "name": "blue_of_london",
        "description": "베르가옷 향과 산뜻한 오렌지 향을 더한 여운과 바디감이 풍부한 블렌딩 홍차",
        "category": "tea",
        "price": 4500
    })
    menu_collection.insert_one({
        "name": "chamomile_apple_spicy",
        "description": "캐모마일, 사과 스파이스 허브를 블렌딩하여 따뜻함과 편안함을 느낄 수 있는 허브 블렌딩 티",
        "category": "tea",
        "price": 4500
    })

    print("menu 컬렉션이 생성되었습니다.")

# register_menu()

def update_sign_language_description():

    menu_collection = db["menu"]

    descriptions = {
        "americano": "커피, 진하다, 쓰다, 우유, 없다, 당, 약하다",
        "cafe_latte": "우유, 커피, 부드럽다, 넣다",
        "wild_dry_cappuccino": "커피, 우유, 부풀다, 커피, 섞다, 부드럽다, 향기, 당, 좋다",
        "roasted_almond_latte": "커피, 호두, 향기, 좋다, 당, 섞다, 마시다",
        "muscovado_latte": "우유, 성숙, 당, 사용, 특별, 커피, 섞다, 맛, 깊다, 무겁다, 마시다",
        "brown_sugar_macchiato": "ㄷ, ㅐ, ㅁ, ㅏ, ㄴ, 당, 갈색, 위, 뿌리다, 당, 커피, 맛, 깊다",
        "jeju_green_oat_latte": "녹차, 우유, ㄱ, ㅟ, ㄹ, ㅣ, 섞다, 맛, 좋다, 진하다, 마시다",
        "sweet_coffee": "위, 아이스크림, 커피, 함께, 녹다, 부드럽다, 달다",
        "piggybank_choco_latte": "ㅊ, 코, 우유, 넣다, 부드럽다, 달다",
        "bank_schpanner": "생크림, 위, 달다, 부드럽다, 커피, 섞다, 부드럽다",
        "elderflower_ade": "꽃, ㅇ, ㅔ, ㄹ, 향기, 좋다, 꽃, 먹다, 예쁘다, 과일, 마시다, 시원하다, 좋다",
        "passion_berry_ade": "과일, ㄹ, ㅏ, ㅈ, 시다, 좋다, 과일, ㅂ, ㄹ, ㅜ, 달다, 섞다, 마시다, 시원하다",
        "cafe_coco_and_shot_smoothie": "과일, ㅋ, ㅗ, 달다, 얼음, 갈다, 섞다, 커피, 진하다, 위, 마시다, 시원하다",
        "plain_yogurt_smoothie": "우유, ㅇ, ㅛ, 달다, 맛, 진하다, 부드럽다, 얼음, 갈다, 섞다, 마시다",
        "berry_yogurt_smoothie": "과일, ㄹ, ㅏ, ㅈ, 시다, 과일, ㅂ, ㄹ, ㅜ, 달다, 우유, ㅇ, ㅛ, 얼음, 갈다, 섞다, 마시다",
        "verveine_orange_mint": "ㅎ, ㅓ, ㅂ, 향기, 좋다, 과일, 시다, 부드럽다, 섞다, 차, 마시다, 시원하다",
        "rooibos_de_vanille": "차, ㄹ, ㅜ, ㅇ, 달다, 향기, 좋다, 부드럽다, 호두, 마시다",
        "blue_of_london": "향기, 좋다, 과일, 시다, 향기, 좋다, 진하다, 무겁다, 많다, 섞다, ㅎ, ㅗ, ㅇ, 차, 마시다",
        "chamomile_apple_spicy": "ㅋ, ㅐ, ㅁ, 꽃, 사과, 맛, 진하다, 꽃, 향기, 먹다, 섞다, 차, 따뜻하다, 편하다, 느끼다"
    }

    for name, desc in descriptions.items():
        menu_collection.update_one(
            {"name": name}, {"$set": {"sign_language_description": desc}}
        )

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
    spreadsheet = gc.open_by_key(spreadsheet_id)
    sheet = spreadsheet.get_worksheet_by_id(859465925)  

    # 전체 행을 삽입하는 경우
    data = sheet.get_all_records()

    print(data)
    # sign_language_collection.insert_many(data)

    # headers = sheet.row_values(1)

    # 단일 행을 삽입하는 경우
    # row_new = sheet.row_values(71)

    # if row_new:
    #     data_new = dict(zip(headers, row_new))

    #     sign_language_collection.insert_one(data_new)

    # 여러 행을 삽입하는 경우
    # rows_new = sheet.get(f"A72:Z74")  

    # if rows_new:
    #     data_list = [dict(zip(headers, row)) for row in rows_new]  

    #     sign_language_collection.insert_many(data_list) 
    print("sign_language 데이터가 MongoDB에 삽입되었습니다.")


# register_sign_language_words()

def download_sign_language_urls():

    creds = Credentials.from_service_account_file(json_key_file, scopes=[
        "https://www.googleapis.com/auth/spreadsheets",
        "https://www.googleapis.com/auth/drive"
    ])
    gc = gspread.authorize(creds)
    spreadsheet_id = os.getenv("SPREADSHEET_ID")
    folder_id = "1ChqG-GqfKEFwddkq5x3SeLqMNUIa-UYc"
    sheet = gc.open_by_key(spreadsheet_id).sheet1
    records = sheet.get_all_records()

    drive_service = build('drive', 'v3', credentials=creds)

    for row in records:
        name = row['name']
        url = row['url']
        download_and_upload_video(url, name, folder_id, drive_service)

def download_and_upload_video(url, filename, folder_id, drive_service):
    
    response = requests.get(url)
    if response.status_code == 200:
        ext = mimetypes.guess_extension(response.headers['Content-Type'])
        if not ext:
            ext = ".mp4"  
        local_path = f"{filename}{ext}"

        with open(local_path, 'wb') as f:
            f.write(response.content)

        file_metadata = {
            'name': os.path.basename(local_path),
            'parents': [folder_id]
        }
        media = MediaFileUpload(local_path, resumable=True)
        uploaded_file = drive_service.files().create(body=file_metadata, media_body=media, fields='id').execute()
        print(f"Uploaded: {filename} (ID: {uploaded_file['id']})")

        os.remove(local_path) 
    else:
        print(f"Failed to download: {url}")


def download_sign_language_urls():
    creds = Credentials.from_service_account_file(json_key_file, scopes=[
        "https://www.googleapis.com/auth/spreadsheets"
    ])
    gc = gspread.authorize(creds)
    spreadsheet_id = os.getenv("SPREADSHEET_ID")
    sheet = gc.open_by_key(spreadsheet_id).sheet1
    records = sheet.get_all_records()

    s3_bucket_name = os.getenv("S3_BUCKET_NAME")

    for row in records[174:]:
        name = row['name']
        url = row['url']
        download_and_upload_video(url, name, s3_bucket_name)

def download_and_upload_video(url, filename, bucket_name):
    response = requests.get(url)
    if response.status_code == 200:
        ext = mimetypes.guess_extension(response.headers.get('Content-Type', 'video/mp4'))
        if not ext:
            ext = ".mp4"
        local_path = f"{filename}{ext}"

        with open(local_path, 'wb') as f:
            f.write(response.content)

        s3 = boto3.client('s3')
        s3.upload_file(local_path, bucket_name, os.path.basename(local_path),ExtraArgs={
        'ContentType': 'video/mp4',
        'ContentDisposition': 'inline'
    })
        print(f"Uploaded to S3: {filename}")

        os.remove(local_path)
    else:
        print(f"Failed to download: {url}")

# download_sign_language_urls()

def find_missing_uploaded_files():
    creds = Credentials.from_service_account_file(json_key_file, scopes=[
        "https://www.googleapis.com/auth/spreadsheets",
        "https://www.googleapis.com/auth/drive"
    ])
    gc = gspread.authorize(creds)
    spreadsheet_id = os.getenv("SPREADSHEET_ID")
    folder_id = "1ChqG-GqfKEFwddkq5x3SeLqMNUIa-UYc"

    sheet = gc.open_by_key(spreadsheet_id).sheet1
    records = sheet.get_all_records()
    expected_names = set(row['name'] for row in records if row['name'])

    drive_service = build('drive', 'v3', credentials=creds)

    uploaded_files = []
    page_token = None
    while True:
        response = drive_service.files().list(
            q=f"'{folder_id}' in parents",
            spaces='drive',
            fields='nextPageToken, files(name)',
            pageToken=page_token
        ).execute()
        uploaded_files.extend([file['name'].replace('.mp4', '') for file in response.get('files', [])])
        page_token = response.get('nextPageToken', None)
        if page_token is None:
            break

    uploaded_set = set(uploaded_files)

    missing = expected_names - uploaded_set

    print("\n🔍 누락된 업로드 파일 목록:")
    for name in missing:
        print(f" - {name}")

    return missing

# find_missing_uploaded_files()

def reregister_sign_language_urls():
    creds = Credentials.from_service_account_file(json_key_file, scopes=[
        "https://www.googleapis.com/auth/spreadsheets",
        "https://www.googleapis.com/auth/drive"
    ])
    gc = gspread.authorize(creds)
    spreadsheet_id = os.getenv("SPREADSHEET_ID")
    folder_id = "1ChqG-GqfKEFwddkq5x3SeLqMNUIa-UYc"

    spreadsheet = gc.open_by_key(spreadsheet_id)
    sheet = spreadsheet.get_worksheet_by_id(859465925)  

    drive_service = build('drive', 'v3', credentials=creds)

    query = f"'{folder_id}' in parents"
    files = []
    page_token = None
    while True:
        response = drive_service.files().list(
            q=query,
            fields="nextPageToken, files(id, name)",
            pageToken=page_token
        ).execute()
        files.extend(response.get('files', []))
        page_token = response.get('nextPageToken', None)
        if page_token is None:
            break

    data = [['name', 'url']]
    for file in files:
        file_id = file['id']
        name = os.path.splitext(file['name'])[0] 

        drive_service.permissions().create(
            fileId=file_id,
            body={'type': 'anyone', 'role': 'reader'},
            fields='id'
        ).execute()

        share_url = f"https://drive.google.com/file/d/{file_id}/view?usp=sharing"
        data.append([name, share_url])
        print(f"{name} → {share_url}")

    sheet.clear()
    sheet.update("A1", data)

    print("✅ .mp4 제거 완료 후 시트에 공유 링크 저장됨")

def reregister_sign_language_urls():
    creds = Credentials.from_service_account_file(json_key_file, scopes=[
        "https://www.googleapis.com/auth/spreadsheets"
    ])
    gc = gspread.authorize(creds)
    spreadsheet_id = os.getenv("SPREADSHEET_ID")
    sheet = gc.open_by_key(spreadsheet_id).get_worksheet_by_id(859465925)

    # S3 정보
    s3_bucket = os.getenv("S3_BUCKET_NAME") 
    s3_prefix = ""
    s3 = boto3.client("s3", region_name="ap-northeast-2") 

    base_url = f"https://{s3_bucket}.s3.ap-northeast-2.amazonaws.com"

    response = s3.list_objects_v2(Bucket=s3_bucket, Prefix=s3_prefix)
    objects = response.get("Contents", [])

    data = [['name', 'url']]
    for obj in objects:
        key = obj["Key"]
        if key.endswith("/"):
            continue
        filename = os.path.basename(key)
        name = os.path.splitext(filename)[0]

        encoded_key = urllib.parse.quote(key)
        object_url = f"{base_url}/{encoded_key}"

        data.append([name, object_url])
        print(f"{name} → {object_url}")

    sheet.clear()
    sheet.update("A1", data)
    print("✅ 서울 리전 기반 URL을 퍼센트 인코딩 후 시트에 저장 완료")

# reregister_sign_language_urls()


def register_avatar_sign_language_words():
    sign_language_collection = db["avatar_sign_language"]

    creds = Credentials.from_service_account_file(json_key_file, scopes=[
        "https://www.googleapis.com/auth/spreadsheets",
        "https://www.googleapis.com/auth/drive"
    ])
    gc = gspread.authorize(creds)
    spreadsheet_id = os.getenv("SPREADSHEET_ID")

    spreadsheet = gc.open_by_key(spreadsheet_id)
    # sheet = spreadsheet.get_worksheet(1)
    sheet = spreadsheet.worksheet("아바타시트") 

    data = sheet.get_all_records()
    sign_language_collection.insert_many(data)

    print("avatar sign_language 데이터가 mongo DB에 삽입 되었습니다.")

# register_avatar_sign_language_words()


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


def add_sign_language_urls():
    menu_collection = db["menu"]
    
    # 메뉴 컬렉션의 모든 문서를 가져옴
    menus = menu_collection.find({}, {"name": 1})
    
    for menu in menus:
        menu_name = menu["name"]
        
        url = get_sign_language_url_list(menu_name)
        
        menu_collection.update_one(
            {"name": menu_name}, 
            {"$set": {"sign_language_urls": url}}
        )

# add_sign_language_urls()