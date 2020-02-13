
head(iris)
str(iris)

# par(mfrow=c(2,2), mar=c(1,1,1,1))
plot(iris[,-5])
plot(iris)  # factor에 대해서도 plot 가능

library(corrplot)
iris_cor <- cor(iris[,-5])
iris_cor
corrplot(iris_cor)


?par
?cor
?corrplot

??Freq



?summary
head(attenu)
summary(iris)
table(iris$Species)
