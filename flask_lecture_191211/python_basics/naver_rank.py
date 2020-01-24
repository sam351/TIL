
import requests
from bs4 import BeautifulSoup

response = requests.get('https://www.naver.com/').text
soup = BeautifulSoup(response, 'html.parser')

# # Ver. 1
# result_list = []
# for i in range(10):
#     tmp_child = i+1
#     tmp_selector = f'#PM_ID_ct > div.header > div.section_navbar > div.area_hotkeyword.PM_CL_realtimeKeyword_base > div.ah_roll.PM_CL_realtimeKeyword_rolling_base > div > ul > li:nth-child({tmp_child})'
#     tmp_text = soup.select_one(tmp_selector).text.strip()
#     result_list.append(tmp_text)
#     pass

# print(result_list)
# for item in result_list:
#     print(item.split('\n')[1])

# print('=======================')


# # Ver. 2
# selector = '''#PM_ID_ct > div.header > div.section_navbar > 
# div.area_hotkeyword.PM_CL_realtimeKeyword_base > 
# div.ah_roll.PM_CL_realtimeKeyword_rolling_base > 
# div > ul > li'''
# obj_list = soup.select(selector)

# result_list = [obj.text.strip().split('\n')[1] for obj in obj_list[:10]]
# print(result_list)
# for item in result_list:
#     print(item)


# Ver. 3
selector = '''#PM_ID_ct > div.header > div.section_navbar > 
div.area_hotkeyword.PM_CL_realtimeKeyword_base > 
div.ah_roll.PM_CL_realtimeKeyword_rolling_base > div > 
ul span.ah_k'''
tags = soup.select(selector)
for tag in tags:
    print(tag.text)
    pass

with open('rank_words.txt', 'w', encoding='utf-8') as tmp_file:
    rank_words = [f'{idx+1}. {tag.text}\n' for idx, tag in enumerate(tags)]
    tmp_file.writelines(rank_words)
    pass


