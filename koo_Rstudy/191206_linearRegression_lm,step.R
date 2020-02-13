data("cars")
head(cars)  # 속도에 따른 제동거리 데이터세트

# 1. cars 데이터세트에서 spead에 따른 dist 변화량 회귀분석
m <- lm(formula = dist ~ speed, data = cars)  # 종속~독립 var
m
summary(m)  # dist = 3.932 * speed - 17.579
# boxplot(m$residuals) # 잔차들의 정규성 확인
# qqnorm(m$residuals) # 잔차들의 정규성 확인
# qqline(m$residuals)

cars$speed[1:4]
cars$dist[1:4]
fitted(m)[1:4]  # 예측치
residuals(m)[1:4]  # 각 데이터의 잔차(실측치-예측치)
cars$dist[1:4] - fitted(m)[1:4] == residuals(m)[1:4]

predict(m, newdata = data.frame(speed=c(4, 4, 7, 7)))  # 새로운 데이터 예측


?lm
?fitted
?residuals
?predict



# 2. mlbench::BostonHousing 데이터세트에서 각 변수에 따른 medv 변화량 회귀분석
# install.packages("mlbench")
library(mlbench)
data(BostonHousing)
head(BostonHousing)
str(BostonHousing)

m2 <- lm( medv ~ . ,data = BostonHousing )
m2
summary(m2)



# 2-2. 위의 모델에서 step-wize 방식으로 feature selection하여 모델 최적화
m3 <- step(m2, direction = 'both')
m3

?step


