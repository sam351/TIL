import requests
from decouple import config

# 기본 설정 - .env 파일 필요
token = config('TELEGRAM_BOT_TOKEN')
chat_id = config('CHAT_ID')
app_url = f'https://api.telegram.org/bot{token}'

# # 응답 내용 저장하기
# update_url = app_url + '/getUpdates'
# response = requests.get(update_url)

# # chat_id 찾아서 꺼내기
# result_list = response.json().get('result')
# chat_id = result_list[0].get('message').get('chat').get('id')
# print(chat_id)


# 메세지 보내기
text = '야'
message_url = f'{app_url}/sendMessage?chat_id={chat_id}&text={text}'
response = requests.get(message_url)

print(response)
