v1 <- c(4, 1, 8, 6, 10)
print(v1)

# the maximum of v1
v2 <- max(v1)
# the minimum of v1
v3 <- min(v1)
# the average/mean of v1
v4 <- mean(v1)
# the standard deviation of v1
v5 <- sd(v1)

r1 <- 10
r1 <- 1:10
r1 <- c(1, 2, 3)
r1 <- NULL
r1 <- TRUE
r1 <- 'nums'  # r1 변수에 문자형 리터럴 할당
r1 <- nums  # r1 변수에 변수명 할당

c(10, 20, TRUE)  # 자동형변환(수치형 > 논리형)
c(10, 20, "A")  # 자동형변환(문자형 > 수치형)

help("rep")
rep(1, 100)
rep(1:3, 5)
rep(1:3, times=5)
rep(1:3, each=5)

x <- c(10, 2, 7, 4, 15)
class(x)
range(x)
sort(x)
sort(x, decreasing = T)
rev(x)
order(x)

x[3] <- 20
x <- x + 1
x
summary(x)

x[c(2, 4)]
x[c(F, T, F, T, F)]
x > 5
x[ x>5 ]
x[ x>5 & x<20 ]
x[ x<5 | x>20 ]

names(x)
names(x) <- LETTERS[1:5]
x[2]
x["B"]

c(T, T, F, F) & c(T, F, T, F)
c(T, T, F, F) | c(T, F, T, F)
c(T, T, F, F) && c(F, F, T, F)  # 첫 번째 원소만 비교
c(T, T, F, F) || c(F, F, T, F)  # 첫 번째 원소만 비교

rainfall <- c(21.6, 23.6, 45.8, 77.0, 102.2, 133.3, 327.9, 348.0, 137.6, 49.3, 53.0, 24.9)
rainfall[ rainfall > 100 ]
which(rainfall > 100)
month.name[ which( rainfall>100 ) ]
month.abb[ which( rainfall>100 ) ]
month.korname <- c('1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월')
month.korname[ which( rainfall>100 ) ]
which.max(rainfall)
which.min(rainfall)
month.korname[ which.max(rainfall) ]
month.korname[ which.min(rainfall) ]


paste("I'm", 'Dulli', '!!')
fruit <- c('Apple','Banana','Strawberry')
food <- c('Pie','Juice','Cake')
paste(fruit, food)
paste(fruit, food, sep='')
paste0(fruit, food)

paste(fruit, food, sep='', collapse = '-')
paste(fruit, food, collapse = ',')
