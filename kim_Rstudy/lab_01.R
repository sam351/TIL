# 문제1
v1 <- c(1:10)
v2 <- v1 *2
max_v <- max(v2)
min_v <- min(v2)
avg_v <- mean(v2)
sum_v <- sum(v2)
v3 <- v2[-5]

print(v1)
print(v2)
print(v3)
print(max_v)
print(min_v)
print(avg_v)
print(sum_v)


# 문제3
seq(1, 9, by = 2)
rep(1, 5)
rep(c(1,2,3), 3)
rep(c(1,2,3,4), each=2)


# 문제4
v3 <- seq(1, 10, by=3)
names(v3) <- LETTERS[1:4]


# 문제5
count <- sample(c(1:100), 7)
week.korname <- c('일요일','월요일','화요일','수요일','목요일','금요일','토요일')
names(count) <- week.korname
count

names(count)[ which.max(count) ]
names(count)[ which.min(count) ]
names(count)[ count>50 ]


# 추가학습 - paste
paste(month.korname, count, sep = ' : ')
