library(caret)
library(e1071)

# < Naive Bayes practice > - iris
# 1. generating train, test split
idx = createDataPartition(iris$Species,
                          p = 0.7,
                          list = F)
iris_train = iris[idx, ]
iris_test = iris[-idx, ]

# 2. checking the balance in the split
table(iris_train$Species)
table(iris_test$Species)

# 3. training model & performing validation
naive_result = naiveBayes(iris_train, 
                          iris_train$Species,
                          laplace = 1)
naive_pred = predict(naive_result, 
                     iris_test, 
                     type = 'class')

# 4. evaluating the validation
table(naive_pred, iris_test$Species)
confusionMatrix(naive_pred, iris_test$Species)



# < Naive Bayes practice > - movie genre
# 1. loading data
movie = read.csv('MLData/movie.csv')
head(movie)
summary(movie)

# 2. training model & performing validation
nm = naiveBayes(movie[, 1:5], movie[, 6], laplace = 0)
nm_pred = predict(nm, movie[, 1:5])

# 3. evaluating the validation
sum(movie$장르 != nm_pred)  # only 1 prediction is worng



# < Naive Bayes practice > - spam mail
# 1. loading & checking data
mail = read.csv('MLData/spam.csv')
head(mail)
str(mail)
View(mail)

# 2. handling NA
mail[is.na(mail)] = 0

# 3. training model & performing validation
nm2 = naiveBayes(mail[, 2:13], mail[, 14], laplace = 0)
nm2_pred = predict(nm2, mail[, 2:13])

# 4. evalulating the validation
sum(mail$메일종류 != nm2_pred)


