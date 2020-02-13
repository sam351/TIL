# < 단일집단 평균검정(단일표본 T검정) >
# 1. 데이터 수집 및 전체 상태 파악
data <- read.csv('data/one_sample.csv')
head(data)
str(data)

x <- data$time
summary(x)
# mean(x, na.rm = T)
# table(is.na(x))

# 2. 전처리 - 결측치 제거
x1 <- na.omit(x)
summary(x1)

# 3. 데이터 정규성 확인
shapiro.test(x1)  # H0 : x1이 정규성을 따른다 → p-value=0.7242로 귀무가설 기각 불가
?shapiro.test

hist(x1)

qqnorm(x1)  # 그래프가 직선 상에 몰려 있으면 정규분포
?qqnorm

# 4. t-테스트
mean(x1)  # 5.556881
mu_val <- 5.2
t.test(x1, mu = mu_val)  # H0 : 표본 x1이 추출된 모집단의 평균은 5.2이다 → 기각

t.test(x1, mu = mu_val, alternative = 'greater')  # H0 : 표본 x1이 추출된 모집단의 평균은 5.2보다 크지 않다 → 기각



# < 두 집단 비율검정 >
# 1. 데이터 수집 및 전체 상태 파악
data2 <- read.csv('data/Part-III/two_sample.csv')
head(data2)
str(data2)
table(data2$method)
table(data2$survey)

# 2. 범주형 데이터의 분포를 빈도 테이블로 파악
x <- data2$method
y <- data2$survey
table(x, y, useNA = 'ifany')
?table
# margin.table(table(x,y), 2)

# 3. prop.test()
prop.test( x = c(110, 135), n = c(150, 150) )  # 150명 중 110명 만족, 150명 중 135명 만족

prop.test( x = c(110, 135), n = c(150, 150), alternative = 'less' )



# 두 집단 평균검정(독립표본 T검정)
# 1. 데이터 수집 및 전체 상태 파악 - 위 데이터 그대로 사용

# 2. 전처리 - na가 아닌 행만 추출 & method, score 열만 추출
table(is.na(data2$score))
table(is.na(data2$method))

result <- subset(data2, !is.na(score), c(method, score))
head(result)
length(data2$score); length(result$score)  # 73개 제외 확인

# 3. 전처리 - method에 따라 두 개의 집단으로 분류
table(result$method)
a <- subset(result, method == 1)
b <- subset(result, method == 2)

length(a$score); length(b$score)
a1 <- a$score
b1 <- b$score
mean(a1); mean(b1)
var(a1); var(b1)

# 4. 사전 분석 - 두 집단 간의 등분산성 확인
var.test(a1, b1)  # H0 : 두 집단의 분산에 차이가 없다 → p-value 0.3002로 귀무가설 기각 불가

# 5. t.test
t.test(a1, b1, var.equal = T)
?t.test



# < 대응 두 집단 평균검정(대응표본 T검정) >
data3 <- read.csv('data/Part-III/paired_sample.csv')
head(data3)
summary(data3)  # na 4개 확인

result <- subset(data3, !is.na(after), c(before, after))  # datat3에서, after 열 값이 na가 아닌 행을 추출하고, 그 중에서 before, after 열만 추출
head(result)
summary(result)

x <- result$before
y <- result$after
mean(x); mean(y)
length(x); length(y)

var.test(x, y, paired=T)
?var.test

t.test(x, y, paired = T)  # H0 : 두 집단의 평균은 차이가 없다 → p-value < 0.001이므로 귀무가설 기각
t.test(x, y, alternative = 'less', paired = T)
t.test(x, y, alternative = 'greater', paired = T)



# < 0 >
