# setwd()
rm(list=ls())


# 로지스틱 회귀 연습문제 1. 직원들의 지각여부 예측하기
## 데이터 로드 & 확인
drink = read.csv('MLData/drink.csv')
str(drink)
View(drink)

## 모델 학습
m = glm(지각여부 ~ . , 
        family = binomial(link = 'logit') , 
        data = drink)
m
summary(m)

## 학습 데이터 예측 & 비교
predict(m, type='response')
prediction_vec = ifelse(predict(m, type='response') >= 0.5, 'Y_predict', 'N_predict')

table(drink$지각여부, prediction_vec)



# 로지스틱 회귀 연습문제 2. 각종 성적으로 입학 여부 예측하기
# install.packages("aod")
# library(aod)
library(ggplot2)

## 데이터 로드 & 확인
mydata <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")

head(mydata)
str(mydata) # 데이터 구조 확인
summary(mydata) # 데이터의 대략적인 분포 확인

sapply(mydata, sd) # 변수별 표준편차 확인 y, data)
xtabs( ~ admit + rank, data = mydata ) # contingency table : xtabs(~ x + y, data)
?xtabs  # table 함수와 유사

## 모델 학습
mydata$rank <- factor(mydata$rank)
# mydata$admit <- factor(mydata$admit)  # 안 해도 glm에서 자동 변환됨
mylogit <- glm(admit ~ gre + gpa + rank, 
               data = mydata, family = "binomial")
summary(mylogit)
exp(0.002264)  # = 1.002267 이므로, gre가 1 증가할 때 합격확률의 오즈비는 0.002267 증가
exp(coef(mylogit))  # 전체 계수에 대한 오즈비
?coef  # 모델의 coefficients 리턴



# 다중 로지스틱 회귀 (아직 미완...)
# install.packages("foreign")
library(foreign)
ml = read.dta("https://stats.idre.ucla.edu/stat/data/hsbdemo.dta")



