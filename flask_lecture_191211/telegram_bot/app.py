from flask import Flask
from flask import request
from flask import render_template
from decouple import config
import requests
import random
app = Flask(__name__)

# 기본 설정 - .env 파일 필요
token = config('TELEGRAM_BOT_TOKEN')
chat_id = config('CHAT_ID')
app_url = f'https://api.telegram.org/bot{token}'
naver_client_id = config('NAVER_CLIENT_ID')
naver_client_secret = config('NAVER_CLIENT_SECRET')

# # 1. 메세지 전송 연습
# @app.route('/write')
# def write():
#     return render_template('write.html')
# 
# @app.route('/send')
# def send():
#     message = request.args.get('message')
#     message_url = f'{app_url}/sendMessage?chat_id={chat_id}&text={message}'
#     requests.get(message_url)
#     return f'메세지 "{message}" 전송 완료'


# # 2. 텔레그램 챗봇에 메세지 보내면 에코(그대로 따라 말하기)하는 기능
# @app.route(f'/{token}', methods=["POST"])
# def telegram():
#     # 1. request print 해보기
#     from_telegram = request.get_json()

#     chat_id = from_telegram.get('message').get('from').get('id')
#     text = from_telegram.get('message').get('text')

#     requests.get(f'{app_url}/sendMessage?chat_id={chat_id}&text={text}')

#     return '', 200


# # 2. + 텔레그램 챗봇에 '/로또'라고 입력하면, 로또 번호 6자리를 뽑아주는 기능 추가
# @app.route(f'/{token}', methods=['POST'])
# def telegram_lotto():
#     from_telegram = request.get_json()

#     chat_id = from_telegram.get('message').get('from').get('id')
#     text = from_telegram.get('message').get('text')

#     if text == '/로또':
#         numbers_text =  ', '.join( lotto_nums() )
#         reply = f'오늘의 로또 번호는 {numbers_text} 어떠세요?'
#         pass
#     else:
#         # '/로또'가 아니면 에코
#         reply = text
#         pass
    
#     requests.get(f'{app_url}/sendMessage?chat_id={chat_id}&text={reply}')
#     return '', 200

# def lotto_nums():
#     numbers = [ number for number in random.sample(range(1, 46), 6) ]
#     numbers = sorted(numbers)
#     numbers = [ str(number) for number in numbers ]
#     return numbers


# # 2. ++ 텔레그램 챗봇에 '/번역 {영문장}'라고 입력하면, 번역 해주는 기능 추가
# @app.route(f'/{token}', methods=['POST'])
# def telegram_lotto():
#     from_telegram = request.get_json()
#     print(from_telegram)

#     chat_id = from_telegram.get('message').get('from').get('id')
#     text = from_telegram.get('message').get('text')

#     if text == '/로또':
#         numbers_text =  ', '.join( lotto_nums() )
#         reply = f'오늘의 로또 번호는 {numbers_text} 어떠세요?'
#         pass
#     elif text[:4] == '/번역 ':  # '/번역 영문장'
#         headers = {
#             "X-Naver-Client-Id" : naver_client_id,
#             "X-Naver-Client-Secret" : naver_client_secret
#         }
#         data = {
#             'source': 'en',
#             'target': 'ko',
#             'text' : text[4:]
#         }
#         papago_url = 'https://openapi.naver.com/v1/papago/n2mt'

#         papago_res = requests.post( papago_url, data = data, headers = headers )
#         papago_res_dict = papago_res.json()
#         trans_text = papago_res_dict.get('message').get('result').get('translatedText')
#         reply = f'번역 결과 : {trans_text}'
#         pass
#     else:
#         # '/로또'가 아니면 에코
#         reply = text
#         pass
    
#     print(from_telegram)
#     requests.get(f'{app_url}/sendMessage?chat_id={chat_id}&text={reply}')
#     return '', 200

# def lotto_nums():
#     numbers = [ number for number in random.sample(range(1, 46), 6) ]
#     numbers = sorted(numbers)
#     numbers = [ str(number) for number in numbers ]
#     return numbers


# 2. +++ 텔레그램 챗봇에 사진 전달해, 유명인 추정해주는 기능 추가
@app.route(f'/{token}', methods=['POST'])
def telegram_lotto():
    from_telegram = request.get_json()

    chat_id = from_telegram.get('message').get('from').get('id')
    text = from_telegram.get('message').get('text')

    if from_telegram.get('message').get('photo') is not None:
        # 1. 우선 파일의 아이디 값을 가져온다.
        file_id = from_telegram.get('message').get('photo')[-1].get('file_id')
        # 2. 가져온 파일 아이디로 실제 파일을 가져온다. (getFile 메서드)
        file_res = requests.get(f'{app_url}/getFile?file_id={file_id}')
        # 3. file path를 뽑아내서 저장
        file_path = file_res.json().get('result').get('file_path')
        # 4. 최종적으로 해당 파일의 경로를 찾아서 저장
        file_url = f'https://api.telegram.org/file/bot{token}/{file_path}'
        # 5. 사진(파일)이 있는 주소로 요청을 보내서 가져오자!
        real_file_res = requests.get(file_url, stream=True)

        headers = {
                "X-Naver-Client-Id" : naver_client_id,
                "X-Naver-Client-Secret" : naver_client_secret
        }
        clova_res = requests.post(
            'https://openapi.naver.com/v1/vision/celebrity',
            headers=headers,
            files = {
                'image' : real_file_res.raw.read()
            }
        )

        # 닮은 유명인이 있을 경우
        if clova_res.json().get('info').get('faceCount'):
            celebrity = clova_res.json().get('faces')[0].get('celebrity')
            reply = f"{celebrity.get('value')} - {celebrity.get('confidence')}"
        else:
            reply = '인식된 사람이 없습니다.'
        pass

    else:
        if text == '/로또':
            numbers_text =  ', '.join( lotto_nums() )
            reply = f'오늘의 로또 번호는 {numbers_text} 어떠세요?'
            pass
        elif text[:4] == '/번역 ':  # '/번역 영문장'
            headers = {
                "X-Naver-Client-Id" : naver_client_id,
                "X-Naver-Client-Secret" : naver_client_secret
            }
            data = {
                'source': 'en',
                'target': 'ko',
                'text' : text[4:]
            }
            papago_url = 'https://openapi.naver.com/v1/papago/n2mt'

            papago_res = requests.post( papago_url, data = data, headers = headers )
            papago_res_dict = papago_res.json()
            trans_text = papago_res_dict.get('message').get('result').get('translatedText')
            reply = f'번역 결과 : {trans_text}'
            pass
        else:
            # '/로또'가 아니면 에코
            reply = text
            pass
    
    requests.get(f'{app_url}/sendMessage?chat_id={chat_id}&text={reply}')
    return '', 200

def lotto_nums():
    numbers = [ number for number in random.sample(range(1, 46), 6) ]
    numbers = sorted(numbers)
    numbers = [ str(number) for number in numbers ]
    return numbers




if __name__ == "__main__":
    app.run(debug=True)
    pass





