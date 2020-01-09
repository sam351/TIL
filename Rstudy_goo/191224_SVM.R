# < SVM practice in pdf 교안 >
install.packages("kernlab")
library(kernlab)

# 1. iris 데이터로 학습
m = ksvm(Species ~ . , data = iris)
m

# 2. 학습 데이터를 다시 넣어 fitting rate 확인 - 너무 높으면 overfitting 위험
head(predict( m, newdata = iris ))

# + 다양한 커널 함수 튜닝 방식
ksvm(Species~. , data=iris, kernel='vanilladot')
ksvm(Species~.,data=iris,kernel="polydot",kpar=list(degree=3))



# < SVM practice in 강사님 프린트 교안 >
library(MASS)
library(e1071)

# 1. 데이터 로드 및 확인
set1 = read.csv('MLData/set1.csv', header = T,
                stringsAsFactors = F)
str(set1)
head(set1, 2)
any(is.na(set1))

# 2. plotting data
plot(set1)  # 변수 간 특별한 선형관계 보이지 않음
density = kde2d(set1$food, set1$book, n=400)
image(density, xlab = 'food', ylab = 'book')

# 3. training model 1 - e1071::svm()
m1 = svm(status ~ food + book + cul + cloth + travel,
         data = set1, type = 'C-classification')
m1
attributes(m1)
m1$gamma; m1$cost

sum(predict(m1, set1) != set1$status)  # 오분류 갯수 12개
sum(predict(m1, set1) != set1$status)/length(set1$status)  # 오분류율 12%

## 3-2. tunning model parameters(gamma, cost)
m1_tune = tune.svm(status ~ . , data = set1, gamma = 2^(-4:1), cost = 2^(0:4))
attributes(m1_tune)
m1_tune$best.parameters

# 4. training model 2 - kernlab::ksvm()
m2 = ksvm(status ~ . , kernel = 'rbfdot',
          data = set1)
m2

sum( (predict(m2, set1)>0.5) != set1$status )  # 오분류 갯수 17개
sum( (predict(m2, set1)>0.5) != set1$status)/length(set1$status)  # 오분류율 17%


