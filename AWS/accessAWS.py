# !pip3 install boto3
# !pip3 install gspread
# !pip3 install oauth2client
# !pip3 install python-dotenv
import boto3
import gspread
import os
import urllib
from dotenv import load_dotenv
load_dotenv(dotenv_path='.env')
from oauth2client.service_account import ServiceAccountCredentials

def AWS_setting():
    # 기본 AWS Access 관련 설정값
    try :
        AWS_ACCESS_KEY_ID = os.getenv("AWS_ACCESS_KEY_ID")
        AWS_SECRET_ACCESS_KEY = os.getenv("AWS_SECRET_ACCESS_KEY")
        AWS_SESSION_TOKEN = os.getenv("AWS_SESSION_TOKEN")
        AWS_DEFAULT_REGION = os.getenv("AWS_DEFAULT_REGION")
        # 버킷 불러오기
        s3 = boto3.client('s3',
                          aws_access_key_id = AWS_ACCESS_KEY_ID,
                          aws_secret_access_key = AWS_SECRET_ACCESS_KEY,
                          aws_session_token = AWS_SESSION_TOKEN,
                          region_name = AWS_DEFAULT_REGION)
        return s3
    except :
        print("Failed to load AWS keys")
        return 0

def Spreadsheet_setting() :
    try :
        # 기본 SpreadSheet Access 관련 설정값
        scope = [os.getenv("SHEET_SCOPE_1"),os.getenv("SHEET_SCOPE_2")]
        keyfile = os.getenv("SHEET_KEYFILE")
        creds = ServiceAccountCredentials.from_json_keyfile_name(keyfile, scope)
        client = gspread.authorize(creds)

        # SpreadSheet 열기
        spreadsheet_id = os.getenv("SHEET_ID")
        spreadsheet = client.open_by_key(spreadsheet_id)
        sheet = spreadsheet.worksheet('아바타시트')
        return sheet
    except :
        print("Failed to load Spreadsheet keys")
        return 0


def getData(s3,bucket_name) :
    # List object로 원하는 버킷 리스트로 불러오기 및 Key값(파일명) 가져오기
    file_name = []
    file_url = []

    # URL 생성
    s3_prefix = ""
    base_url = f"https://{bucket_name}.s3.ap-northeast-2.amazonaws.com"
    response = s3.list_objects(Bucket=bucket_name, Prefix=s3_prefix)
    objects = response.get("Contents", [])

    for obj in objects:
        key = obj["Key"]
        if key.endswith("/"):
            continue
        encoded_key = urllib.parse.quote(key)
        object_url = f"{base_url}/{encoded_key}"
        file_name.append([key.replace(".mp4","")])
        file_url.append([object_url])

        # s3 버킷 속에 있는 파일 제목과 url을 텍스트 파일로 빼기 (미사용)
        # with open("s3bucketoutput.txt","w") as f:
        #     f.write(f'{key.replace(".mp4","")}={object_url}\n')
    return [file_name, file_url]


def main():
    bucket_name = os.getenv("AWS_BUCKET_NAME")
    data_sheet = Spreadsheet_setting()
    if (AWS_setting()):
        res = getData(AWS_setting(),bucket_name)
        if (data_sheet) :
            # 수어 뜻 업데이트
            data_sheet.update(res[0],f'A2:A{len(res[0])+1}')

            # 수어 아바타 url 업데이트
            data_sheet.update(res[1],f'B2:B{len(res[1])+1}')

if __name__ == "__main__":
    main()

