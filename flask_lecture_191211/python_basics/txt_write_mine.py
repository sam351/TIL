
with open('mulcam.txt', 'w') as tmp_file:
    for i in range(4):
        tmp_str = f'{i}\n'
        tmp_file.write(tmp_str)
    pass

with open('mulcam.txt', 'r') as tmp_file:
    lines = tmp_file.readlines()
    pass

numbers = [int(line) for line in lines]
numbers = sorted(numbers, reverse=True)
print(lines)
print(numbers)

with open('mulcam.txt', 'w') as tmp_file:
    for item in numbers:
        tmp_str = f'{item}\n'
        tmp_file.write(tmp_str)
    pass



