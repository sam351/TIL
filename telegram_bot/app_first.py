from flask import Flask
from decouple import config
app = Flask(__name__)

# 기본 설정 - .env 파일 필요
token = config('TELEGRAM_BOT_TOKEN')
app_url = f'https://api.telegram.org/bot{token}'

@app.route('/')
def hello():
    return 'hello world'

if __name__ == "__main__":
    app.run(debug=True)
    pass
