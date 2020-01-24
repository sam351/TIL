from flask import Flask
from flask import render_template
from flask import request
import requests
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World!'
    pass

@app.route('/mulcam')
def mulcam():
    return 'This is mulcam'

# @app.route('/greeting/eric')
# def greeting():
#     return 'Hello, eric!'

@app.route('/greeting/<string:name>')
def greeting(name):
    return f'Hello, {name}!'

@app.route('/cube/<int:num>')
def cube(num):
    result = num**3
    return str(result)

@app.route('/lunch/<int:people>')
def lunch(people):
    import random
    menu = ['짜장면','짬뽕','볶음밥','고추잡채밥']
    order = random.sample(menu, people)
    return str(order)

@app.route('/html')
def html():
    return '<h1>안녕하세요!!</h1>'

# flask.render_template() 사용해 /templates 디렉토리에 마련된 html 파일 렌더링하기
@app.route('/html_file')
def html_file():
    return render_template('html_file.html')

@app.route('/hi/<string:name>')
def hi(name):
    return render_template('hi.html', your_name = name)

# 입력된 검색어에 대한 네이버 검색결과 보여주기
@app.route('/naver')
def naver():
    return render_template('naver.html')

# ping-pong 시나리오
@app.route('/ping')
def ping():
    return render_template('ping.html')

@app.route('/pong')
def pong():
    name = request.args.get('name')
    message = request.args.get('message')
    return render_template('pong.html', name=name, message=message)

# ping-pong 시나리오 - 봉봉 서비스
@app.route('/vonvon')
def vonvon():
    return render_template('vonvon.html')

@app.route('/vonvon_result')
def vonvon_result():
    import random
    nickname = request.args.get('nickname')
    features = ['똑똑함', '유머감각', '왕발', '의리', '코딩 실력']
    chosen = random.sample(features, 3)
    chosen = ", ".join(chosen)
    return render_template('vonvon_result.html', name=nickname, chosen=chosen)

# ping-pong 시나리오 - 입력된 단어의 ASCIIfy 결과 보여주기
@app.route('/ascii')
def make_ascii():
    return render_template('ascii.html')

@app.route('/ascii_result')
def ascii_result():
    # 1. form 태그로 날린 데이터(word)를 받는다.
    word = request.args.get('word')

    # 2. word를 가지고 ascii_art API 요청 주소로 요청을 보낸다.
    result = requests.get(f'http://artii.herokuapp.com/make?text={word}').text
    
    # 3. API 응답 결과를 html 파일에 담아 보여준다.
    return render_template('ascii_result.html', result = result)

# # 입력한 회차의 로또번호 보여주기
# @app.route('/lotto_check')
# def lotto_check():
#     return render_template('lotto_check.html')

# @app.route('/lotto_result')
# def lotto_result():
#     lotto_round = request.args.get('lotto_round')
#     response = requests.get(f'https://dhlottery.co.kr/common.do?method=getLottoNumber&drwNo={lotto_round}')
#     lotto = response.json()

#     winner = []
#     for i in range(6):
#         idx = i+1
#         tmp_num = lotto.get(f'drwtNo{idx}')
#         winner.append(tmp_num)
#         pass
#     winner.append( lotto.get('bnusNo') )

#     return render_template('lotto_result.html', 
#                             lotto_round = lotto_round, winner = winner )

# 입력한 회차에서, 입력된 6개의 번호가 몇 개나 일치하는지 보여주기
@app.route('/lotto_check2')
def lotto_check2():
    return render_template('lotto_check2.html')

@app.route('/lotto_result2')
def lotto_result2():
    
    lotto_round = request.args.get('lotto_round')

    response = requests.get(f'https://dhlottery.co.kr/common.do?method=getLottoNumber&drwNo={lotto_round}')
    lotto = response.json()

    winner = []
    for i in range(6):
        idx = i+1
        tmp_num = lotto.get(f'drwtNo{idx}')
        winner.append(tmp_num)
        pass
    winner.append( lotto.get('bnusNo') )
    
    numbers = request.args.get('numbers')  # string
    numbers = numbers.split()  # list
    numbers_int = [ int(number) for number in numbers ]


    matched = len( set(winner) & set(numbers_int) )
    if matched == 6:
        result = '1등입니다!!!'
    elif matched == 5:
        if lotto['bnusNo'] in numbers_int:
            result = '2등입니다!!!'
        else:
            result = '3등입니다!!!'
    elif matched == 4:
        result = '4등입니다!!!'
    elif matched == 3:
        result = '3등입니다!!!'
    else:
        result = '꽝입니다...'

    return render_template('lotto_result2.html', 
                            lotto_round = lotto_round, winner = winner,
                            numbers = numbers_int, result = result )


# 파일이 다른 파일에 임포트되지 않고 직접 실행될 때만 실행되는 라인
if __name__ == '__main__':
    app.run(debug=True)


