import requests
from bs4 import BeautifulSoup

response = requests.get('https://finance.naver.com/marketindex/?tabSel=exchange#tab_section').text
soup = BeautifulSoup(response, 'html.parser')
select = soup.select_one('#exchangeList > li:nth-child(1) > a.head.usd > div > span.value')
print(select.text)
