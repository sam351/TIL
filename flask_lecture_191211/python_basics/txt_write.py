
# 파일 쓰기
f = open('mulcam.txt', 'w')
for i in range(10):
    f.write(f'this is line {i}.\n')
f.close()

# 파일 쓰기 - with 사용
with open('mulcam2.txt', 'w') as f:
    for i in range(10):
        f.write(f'this is line {i}.\n')
    pass

# 파일 읽기 - with 사용
with open('mulcam.txt','r') as f:
    lines = f.readlines()

    for line in lines:
        print(line.strip())

    pass
