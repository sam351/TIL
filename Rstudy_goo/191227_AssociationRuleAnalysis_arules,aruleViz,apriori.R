# install.packages("arules")
# install.packages("arulesViz")
# install.packages("sna")
# install.packages("rgl")

library(arules)
library(arulesViz)
library(sna)
library(rgl)

# < Association Rule Analysis practice > - arules::Groceries
# 1. loading & checking data
data("Groceries")

str(Groceries)
Groceries
inspect(Groceries[1:10])
summary(Groceries)

# 2. exploring most frequent items
head(sort(itemFrequency(Groceries, type='absolute'), decreasing = T))
itemFrequencyPlot(Groceries, topN=10, 
                  type='absolute')
itemFrequencyPlot(Groceries, topN=10, 
                  type='relative', ylim=c(0,0.3))

# 3. performing analysis
apriori(Groceries)  # (Default) support = 0.1, confidence = 0.8
result_rules = apriori(Groceries,
                       parameter = list(support = 0.005,
                                        confidence = 0.5,
                                        minlen = 2))
result_rules
summary(result_rules)
inspect(result_rules[1:10])



# < Association Rule Analysis practice > - building.csv (강사님 프린트 교안)
# 1. loading & checking & preprocessing data
build = read.csv('MLData/building.csv')
str(build)
head(build, 2)

build[is.na(build)] = 0
build = build[-1]
head(build, 2)

trans = as.matrix(build)

# 2. performing arules analysis
rules1 = apriori(trans,
                 parameter = list(conf = 0.6,
                                  supp = 0.2,
                                  target = 'rules'))
rules1
inspect(rules1[1:5])

# 3. checking subsets in the rules
rules2 = subset(rules1, 
                subset = lhs %pin% '보습학원' & 
                  confidence > 0.7)
rules2
inspect(sort(rules2))

rules3 = subset(rules1,
                subset = lhs %pin% '편의점' & 
                  confidence > 0.7)
rules3
inspect(sort(rules3))

# 4. visualizing
b2 = t(as.matrix(build)) %*% as.matrix(build)
b2_w = b2 - diag(diag(b2))  # 행렬에서 대각성분만 삭제
rownames(b2_w)
colnames(b2_w)
gplot(b2_w, displaylabels = T, 
      vertex.cex = sqrt(diag(b2)),
      # vertex.col = 'green', edge.col = 'blue',
      boxed.labels = F, arrowhead.cex = 0.3,
      label.pos = 3, edge.lwd = b2_w*2)
