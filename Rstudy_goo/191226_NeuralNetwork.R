library(caret)
library(nnet)

# < NN practice > - iris
# 1. generating train-test split
idx = createDataPartition(iris$Species,
                          p = 0.7,
                          list = F)
iris_train = iris[idx,]
iris_test = iris[-idx,]
table(iris_train$Species)
table(iris_test$Species)

# 2. scaling the variables(FE) - 데이터 표준화(Z-score standardization)
iris_train_scale = as.data.frame(sapply(iris_train[-5] , scale))
iris_train_scale$Species = iris_train$Species

iris_test_scale = as.data.frame(sapply(iris_test[-5] , scale))
iris_test_scale$Species = iris_test$Species

# 3. training model & performing validation
nnet_result = nnet(Species ~ . , iris_train_scale, size = 3)
nnet_pred = predict(nnet_result, iris_test_scale, type = 'class')

# 4. evalulating the validation
table(nnet_pred, iris_test$Species)



# < NN practice > - military problem (강사님 프린트 교안)
# 1. loading & checking data
prob = read.csv('MLData/problem.csv', stringsAsFactors = F)
head(prob, 2)
summary(prob)
table(prob$accident)  # 타겟변수 구성 확인
table(prob$ans1)  # 설명변수 구성 확인인
table(prob$ans2)  # 설명변수 구성 확인인

# 2-1. scaling X-variables(FE)
## method1
for (i in 1:30) {
  prob[i] = prob[i] * 1/5
}
summary(prob)
## method2 - min_max_scaler(normalize)
normalize = function(x) {
  return( (x-min(x)) / diff(range(x)) )
}
## method3 - sigmoid(x) : returns 0~1

# 2-2. scaling Y-variable(FE)
prob$accident2 = with(prob,
                      ifelse(accident %in% c('suicide', 'violence'),
                             1, 0))
prob = prob[-31]
head(prob)

# 3. training model & performing validation
m1 = nnet( accident2 ~ . , data = prob,
           size = 10 )
r1 = predict(m1, prob)
range(r1)
head(r1)
# summary(r1)
# sum(range(r1))

# 4. evaluating the validation
cbind(prob$accident2, r1>0.5)
sum(as.numeric(r1>0.5) != prob$accident2)  # 오답 개수
sum(as.numeric(r1>0.5) != prob$accident2)/nrow(prob)  # 오답률

# 5. bagging - train & validate for 1000*3 iteration
r1_vec = c()
wrong_ratio_vec = c()
for (i in 1:1000) {
  m1 = nnet( accident2 ~ . , data = prob,
             size = 10 )
  r1 = predict(m1, prob)
  r1_vec = c(r1_vec, sum(range(r1)))
  wrong_ratio_vec = c(wrong_ratio_vec,
                      sum(as.numeric(r1>0.5) != prob$accident2)/nrow(prob))
}
mean(wrong_ratio_vec)  # 0.12642, 0.12686, 0.13692
sum(r1_vec==0)/length(r1_vec)  # 0.508, 0.509, 0.549


# + same task using other package
# install.packages("neuralnet")
library(neuralnet)
xnam = paste0('ans', 1:30)
fmla = as.formula( paste('accident2 ~ ', 
                         paste(xnam, collapse = '+')) )
m2 = neuralnet(fmla, data = prob, hidden = 10)
r2 = predict(m2, prob)
range(r2)
sum(as.numeric(r2>0.5) != prob$accident2)
plot(m2)

# + bagging with neuralnet()
r2_vec = c()
wrong_ratio_vec = c()
for (i in 1:100) {
  m2 = neuralnet(fmla, data = prob, hidden = 10)
  r2 = predict(m2, prob)
  r2_vec = c(r2_vec, sum(range(r2)))
  wrong_ratio_vec = c(wrong_ratio_vec,
                      sum(as.numeric(r2>0.5) != prob$accident2)/nrow(prob))
}
mean(wrong_ratio_vec)  # 0, 0, 0
sum(r2_vec==0)/length(r2_vec)  # 0, 0, 0


# 결론 - nnet::nnet()은 빠르되 정확도가 떨어지고, neuralnet::neuralnet()은 느리되 정확도가 높으며 plot이 가능함