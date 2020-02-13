#!/usr/bin/env python3
import cgi
from botengine import make_reply
import os.path
import html

# 입력 양식의 글자 추출하기 --- (※1)
form = cgi.FieldStorage()


# 메인 처리 --- (※2)
def main():
    m = form.getvalue("m", default="")
    if   m == "" : show_form()
    elif m == "say" : api_say()


# 사용자의 입력에 응답하기 --- (※3)
def api_say():
    print("Content-Type: text/plain; charset=euc-kr")
    print("")
    txt = form.getvalue("txt", default="")
    if txt == "": return
    res = make_reply(txt)
    print(res)


# 입력 양식 출력하기 --- (※4)
def show_form():
    print("Content-Type: text/html; charset=euc-kr")
    print("")
    with open(os.path.dirname(__file__) + "./templates/chatbot_main.html", encoding="utf-8") as fp:
        tmp_str = fp.read()
        pass
    print(tmp_str)
    pass


main()