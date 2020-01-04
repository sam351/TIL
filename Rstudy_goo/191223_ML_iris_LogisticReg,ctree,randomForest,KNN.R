# install.packages("caret")
library(caret)
library(nnet)
library(rpart)
library(e1071)
library(randomForest)
library(class)

data(iris)

# < practice 1 - logistic regression >
# 1. generating train, test split
set.seed(1234)  # 시드값 고정
idx = createDataPartition( iris$Species, p=0.7, list=F )  # idx = sample(1:nrow(iris), size = nrow(iris)*0.7, replace = F)
head(idx); tail(idx)
class(idx)

iris_train = iris[idx, ]
iris_test = iris[-idx, ]

# 2. checking the balance of split
table(iris_train$Species)
table(iris_test$Species)

# 3. training model - logistic regression
library(nnet)
model = multinom(Species ~ . , data = iris_train)
summary(model)

# 4. testing the model & evaluating
result = predict(model, iris_test)
result

confusionMatrix(result, iris_test$Species)



# < practice 2 - ctree >
# 1. generating train, test split
# idx = createDataPartition( iris, p=0.7, list = F )
# iris_train = iris[idx, ]
# iris_test = iris[-idx, ]

# 2. checking the balance of split
table(iris_train$Species)
table(iris_test$Species)

# 3. training model - ctree & plotting
library(rpart)
model2 = rpart(Species ~ . , data = iris_train)
plot(model2, margin = 0.2)
text(model2)

# 4. testing the model & evaluating
result2 = predict(model2, iris_test, type='class')
head(result2)

confusionMatrix( result2, iris_test$Species)



# < practice 3 - RandomForest >
library(e1071)  # ???
library(randomForest)

# 1. generating train, test split

# 2. checking the balance of split
table(iris_train$Species)
table(iris_test$Species)

# 3. training model - randomForest
rdf = randomForest( Species ~ . , data = iris_train , importance = T)

# 4. testing the model & evaluating
rdf.pred = predict( rdf, newdata = iris_test, type='response')  # type = response 로 주면 원래 클래스의 이름 보존해 출력 가능???
rdf.pred

confusionMatrix(rdf.pred, iris_test$Species)



# < practice 4 - KNN >
library(class)

model3 = knn(train = iris_train[,-5],
             test = iris_test[,-5],
             cl = iris_train$Species,
             k = 3)  # 원래는 k=1 부터 시작하며 직접 찾아야 함
model3
summary(model3)  # KNN은 학습 시 이미 test 데이터를 입력하기 때문에 따로 predict()할 필요 없음
confusionMatrix( model3, iris_test$Species )

