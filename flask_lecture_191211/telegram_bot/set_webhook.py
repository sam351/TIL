from decouple import config
import requests

# 기본 설정 - .env 파일 필요
token = config('TELEGRAM_BOT_TOKEN')
app_url = f'https://api.telegram.org/bot{token}'

set_webhook_url = f'{app_url}/setWebhook?url=https://ksmo9191.pythonanywhere.com/{token}'
response = requests.get(set_webhook_url)

print(response.text)