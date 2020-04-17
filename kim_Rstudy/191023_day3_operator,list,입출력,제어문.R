# operator
y <- c(0,25,50,75,100)
z <- c(50, 50, 50, 50, 50)
y == z
y != z
y > z
y < z
y >= z
y <= z
y == 50
y > 50

num1 <- 11
num2 <- 3
num1 / num2
num1 %% num2
num1 %/% num2


# list
lds <- list(1,2,3); lds
lds+10  # error
lds[1]
lds[1]+10  # error
lds[[1]]+10
class(lds)
class(lds[1])
class(lds[[1]])

names(lds) <- LETTERS[1:3]; lds
lds[[2]]
lds[['B']]
lds$B

a <- list( a = 1:3,
        b = "a string",
        c = pi,
        d = list( 1, 5) )
a[1]+1  # error
a[[1]]+1
a[[1]][2] <- 100; a

new_a <- unlist(a[1])
a[1]; new_a
names(a) <- NULL; a
names(new_a) <- NULL; new_a


# handling dataset in the Environment
ls()
length(ls())
save(list = ls(), file = 'all_191023.rda')  # saving dataset
rm(list = ls())
load('all_191023.rda')



# read file data
nums <- scan('data/sample_num.txt'); nums
word_ansi <- scan('data/sample_ansi.txt', what = ''); word_ansi
words_utf8 <- scan('data/sample_utf8.txt', what = '', encoding = 'UTF-8'); words_utf8
words_utf8_new <- scan('data/sample_utf8.txt', what = ''); words_utf8_new
lines_ansi <- readLines('data/sample_ansi.txt'); lines_ansi
lines_utf8 <- readLines('data/sample_utf8.txt', encoding = 'UTF-8'); lines_utf8



# 제어문
# if else
randomNum <- sample(1:10, 1)
if (randomNum>5) {
  cat(randomNum, ": 5보다 크군요\n")
  
} else {
  cat(randomNum, ": 5보다 작거나 같군요\n")
}

randomNum <- sample(1:10, 1)
if (randomNum%%2) {
  cat(randomNum, ': 홀수\n')
} else {
  cat(randomNum, ': 짝수\n')
}

score <- sample(0:100, 1)
if (score >= 90) {
  cat(score, '는 A등급입니다\n')
} else if (score >= 80) {
  cat(score, '는 B등급입니다\n')
} else if (score >= 70) {
  cat(score, '는 C등급입니다\n')
} else if (score >= 60) {
  cat(score, '는 D등급입니다\n')
} else {
  cat(score, '는 F등급입니다\n')
}


# for
for (data in month.name) {
  print(data)
}
for(data in month.name) print(data); print('lol')
for(data in month.name) { print(data); print('lol') }

for (i in 1:5) {
  for (j in 1:5) {
    cat('i=', i, 'j=', j, '   ')
  }
  cat('\n')
}

# 구구단 예제
for (dan in 2:9) {
  for (num in 1:9) {
    cat(dan, 'x', num, '=', dan*num, '\t')
  }
  cat('\n')
}

# swith
month <- sample(1:12, 1)
month <- paste(month, '월', sep='')
result <- switch (EXPR = month,
  "12월"=, "1월"=, "2월"="겨울",  
  "3월"=, "4월"=, "5월"="봄",
  "6월"=, "7월"=, "8월"="여름", 
  "9월"=, "10월"=, "11월"="가을"
)
cat(month, '은 ', result, '입니다\n', sep='')

month <- sample(1:12, 1)
month <- paste(month, '월', sep='')
switch (EXPR = month,
        "12월"=, "1월"=, "2월"=cat(month, '은 겨울입니다\n'),  
        "3월"=, "4월"=, "5월"=cat(month, '은 봄입니다\n'),
        "6월"=, "7월"=, "8월"=cat(month, '은 여름입니다\n'), 
        "9월"=, "10월"=, "11월"=cat(month, '은 가을입니다\n'))

num <- sample(1:10, 1); num
switch(EXPR = num, 'A','B','C','D')

for (num in 1:10) {
  cat( num, ":", switch(EXPR = num, 'A','B','C','D'), '\n' )
}

for (num in 1:10) {
  num <- as.character(num)
  cat( num, ":", switch(EXPR = num, '7'='A','8'='B','9'='C','10'='D'), '\n' )
}
