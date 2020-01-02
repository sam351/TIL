
# < Decision Tree (조건부 추론 트리) practice > - airquality
library(party)

# 1. 데이터 상태 확인
str(airquality)
summary(airquality)
nrow(airquality)
sapply(airquality , function(x) { sum(is.na(x)/length(x))*100 } )  # 열별 NA 비율

# 2. ctree(조건부 추론 트리)로 회귀 문제 해결
air_ctree <- ctree(Temp ~ Solar.R + Wind + Ozone, data = airquality)
air_ctree
plot(air_ctree)




# < Random Forest practice > - iris
# install.packages("randomForest")
library(randomForest)

# 1. iris의 Species를 rf로 예측
rf = randomForest(Species ~ . , data = iris, importance=T)
rf
importance(rf)  # MeanDecreaseAccuracy : 노드의 정확도 개선량 , MeanDecreaseGini : 노드의 지니인덱스(불순도) 개선량 - 이 값이 높은 변수가 주요 변수라는 의미로 해석
varImpPlot(rf, main = "varImpPlot of iris")


# 2. 동일한 작업을 Decision Tree로 진행
iris_ctree = ctree(Species ~ . , data = iris)
iris_ctree
plot(iris_ctree)

