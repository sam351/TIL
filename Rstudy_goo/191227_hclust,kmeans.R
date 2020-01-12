library(ggplot2)

# < hierarchical clustering practice > - ggplot2::diamonds
# 1. loading & checking data
data("diamonds")
head(diamonds)
str(diamonds)

# 2. extracting sample data
set.seed(100)
t = sample(1:nrow(diamonds), 1000)
test = diamonds[t, ]
dim(test)
mydia = test[c('price','carat','depth','table')]

# 3. clustering & plotting
result = hclust(dist(mydia), method = 'ave')  # 거리값을 이용한 계층적 군집화 ★ 개별수치가 아닌 거리값을 argument로 입력
class(result)
plot(result, hang=1)



# < k-means clustering practice > - ggplot2::diamonds
# 1. extracting sample data - same with above

# 2. clustering
result2 = kmeans(mydia, 3)  # k=3
result2
names(result2)

# 3. checking statistics by group
group1 = subset(mydia, result2$cluster==1)
group2 = subset(mydia, result2$cluster==2)
group3 = subset(mydia, result2$cluster==3)

summary(group1)
summary(group2)
summary(group3)
str(mydia)

# 4. plotting
mydia$cluster = result2$cluster
head(mydia)

cor(mydia[,-5], method = 'pearson')
plot(mydia[,-5])
plot(mydia$carat, mydia$price, 
     col=mydia$cluster)

# 5. looking for appropriate k (elbow method)
km.out.withinss<-c()
km.out.between<-c()
for (i in 2:7) { 
  set.seed(1)
  km.out = kmeans( mydia, centers = i )
  km.out.withinss[i-1] = km.out$tot.withinss # 군집내제곱합의합
  km.out.between[i-1] = km.out$betweenss # 군집간제곱합의합
}
data.frame(km.out.withinss, km.out.between)

plot(km.out.withinss)
plot(km.out.between)
