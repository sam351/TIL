# t.test() 실습
## 귀무가설 : 만 7세 남아의 키의 평균이 1220mm
xdata <- c(1196, 1340, 1232, 1184, 1295, 1247, 1201, 1182, 1192, 1287, 1159, 1160, 1243, 1264, 1276)
t.test(xdata, mu=1220)  # p-value 0.464로 귀무가설 기각 불가

mean(xdata)  # 표본평균 = 1230.533
sd(xdata)  # 표본표준편차 = 54.18601
length(xdata)  # 표본수 = 15

mean(xdata) - 1220  # 평균의 차 = 10.5333
sd(xdata)/sqrt(length(xdata))  # 표준오차? = 13.99077
(mean(xdata)-1220)/(sd(xdata)/sqrt(length(xdata))) # 최종 t통계량 0.75288 (자유도 14)




# binom.test() 실습 - 단일집단 검정
data <- read.csv('data/Part-III/one_sample.csv')
head(data)
tail(data)

summary(x) # 범주형이라 의미없지만, 결측치 확인에 도움 - any(is.na(x))
summary(as.factor(x)) # 팩터형으로 바꾸어 넣어주면 자동으로 테이블 생성

data$gender <- as.factor(data$gender)
data$survey <- as.factor(data$survey)
summary(data)

x <- data$survey
str(x)
table(x)

# install.packages("prettyR")
library(prettyR)
freq(x)

## 양측검정 - H0:만족비율 80%, H1:만족비율 80% 아님
## 단측검정 - H0:만족비율 80%, H1:만족비율 80% 보다 크다
binom.test( c(136, 14), p=0.8 )  # p-value < 0.0007 이므로 귀무가설 기각
binom.test( c(136, 14), p=0.8, alternative = 'greater' )  # p-value < 0.00032 이므로 귀무가설 기각
binom.test( c(14, 136), p=0.2, alternative = 'less')  # p-value < 0.00032 이므로 귀무가설 기각

?binom.test
?freq


