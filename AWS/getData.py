# !pip3 install boto3
# !pip3 install gspread
# !pip3 install oauth2client
import boto3
import gspread
from oauth2client.service_account import ServiceAccountCredentials

def AWS_setting():
    # 기본 AWS Access 관련 설정값
    AWS_ACCESS_KEY_ID = "ASIAYJN75WM7BXJDUES7"
    AWS_SECRET_ACCESS_KEY = "qQeQPLDkhgPmQMQ7On1VLkuoBNSYuKDWVCSMZ5Kc"
    AWS_SESSION_TOKEN = "IQoJb3JpZ2luX2VjEEoaDmFwLW5vcnRoZWFzdC0yIkYwRAIgCL6QivR+/5v1oF4a95g/8l6wy+HZRAsHlDtn/3Uf60sCIEJjqmZT9S5gBQ61S1fEMqr0kxisz1VxkAXAek6bFGHvKvICCPP//////////wEQARoMNTcwMDIyNTQwMDk0IgwxbvD+vPx9OTsjojsqxgIhXQY6B3sBx5M2UYJkgfZl+A4zZSaBQXq/YEmGwl6/y7xOZsPXx0uufY1Ki6/Gup5r3OkoIkjQ+jUuAxaxaU/bo9VeCi17o3BdNaboD4AX5ExTcQoSxyZFP3Sq7phfeScAa4vNIFZuCbMqFW8XOAJ7yiXcpvnI31r8ccDk16u5SjdxYbX/VOhTB0W7/ZmIKAZthGFg8GdzJeDBR2j8sOwG/GfNlqwm2pxMmGDHeeZzVfOjEz0lCvfdKdfn8GyRV9FH04lwR2EgSHHajpO7yz92/9fag/LNVNf46Hgn4OvHhXbZkBYOVgpzYnWdT2PHxpg39SYTEIYAaWLAxPKApQAZf+ODUzItsQdLtuqtaaosdiQP3zneqmr6YUJz+/4MVUtdWSy2r64VfEfW6hvvbtuBKY3GouJ7gMKiqBtITjwDjCBvmPhoAjD1io7BBjqoAWNLdzL91OszCIbeaWn91GIk8OiHUuR1AX/CH749CpXEXe7kTcESm0rJxFo/3GlRfjHB9z+Pci0rjnE5UP3iN9RJoRifIv6IRApLiDsS7lErgKUmf6kOnw9Rsb/HVjKC8sXsF92n15eOycRlT43sb9fAAX4gKU+dpN2pey5P30Cat6wt9aXiiZGa5ZdzN2ajLQ+n4QuQOp82fDnwk5p76MF40/Rxqplfsg=="
    AWS_DEFAULT_REGION = "ap-northeast-2"
    # 버킷 불러오기
    s3 = boto3.client('s3',
                      aws_access_key_id = AWS_ACCESS_KEY_ID,
                      aws_secret_access_key = AWS_SECRET_ACCESS_KEY,
                      aws_session_token = AWS_SESSION_TOKEN,
                      region_name = AWS_DEFAULT_REGION)
    return s3

def Spreadsheet_setting() :
    # 기본 SpreadSheet Access 관련 설정값
    scope = ["https://spreadsheets.google.com/feeds", "https://www.googleapis.com/auth/drive"]
    creds = ServiceAccountCredentials.from_json_keyfile_name("affable-beach-453501-k9-12086968563e.json", scope)
    client = gspread.authorize(creds)

    # SpreadSheet 열기
    spreadsheet_id = "1xRK-f0sf7E2_4QS81wkbVKwsx7LOAQDPJ7Dt_mIT5gc"
    spreadsheet = client.open_by_key(spreadsheet_id)
    sheet = spreadsheet.worksheet('시트2')
    row_count = sheet.row_count
    return sheet



def getData(s3,bucket_name) :
    # List object로 원하는 버킷 리스트로 불러오기 및 Key값(파일명) 가져오기
    file_name = []
    file_url = []
    obj_list = s3.list_objects(Bucket = bucket_name)
    contents_list = obj_list['Contents']
    for content in contents_list:
        # print(content['Key'])


        # URL 생성하기
        url = s3.generate_presigned_url(ClientMethod='get_object',
                                        Params={
                                            'Bucket' : bucket_name,
                                            'Key' : content['Key'],
                                        }
                                        )
        file_name.append([content['Key']])
        file_url.append([url])
    file_array = [file_name,file_url]
    return file_array

def main():
    bucket_name = "signorderavatarvideo"
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

