# setwd("")


# 1. CART : 목적변수가 범주형(지니지수), 연속형(분산)
# install.packages("rpact")
library(rpart)
?rpart::rpart

str(iris)
m <- rpart( Species ~ . , data = iris )
m
plot(m, margin = 0.05)
text(m, cex = 1)  # cex = character expansion

# install.packages("rpart.plot")
library(rpart.plot)

prp(m, type=4, extra=2, digits=3)
?prp



# 2. 
# install.packages("party")
library(party)

m2 <- ctree(Species ~ . , data=iris)
m2
plot(m2)

