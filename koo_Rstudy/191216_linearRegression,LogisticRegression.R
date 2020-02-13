# ?shapiro.test
# shapiro.test(rnorm(100, mean = 5, sd = 3))
# shapiro.test(runif(100, min = 2, max = 4))

# < 선형회귀 >
# 1. 회귀분석 결과 확인
m = lm(dist ~ speed, data=cars)
summary(m)

# 2. 회귀분석의 결과 plotting
par(mfrow = c(2,2), mar = c(3,3,3,3))
plot(m)
# 플롯1 정리 : x축은 예측값, y축은 잔차 - y값들이 0에 수렴하면 좋은 것. 빨간 선은 해당 구간의 잔차들의 평균
# 플롯 2 정리 : qq플롯으로서, x축은 잔차들의 quantile, y축은 잔차 평균???
# 플롯 3 정리 : 플롯 1에서 std값으로 척도만 변화시킨 것
# 플롯 4 정리 : x축은 영향력(잔차의 크기), y축은 표준화된 잔차

# 3. 회귀분석의 전제 중 잔차의 독립성 평가 - 더빗-왓슨
# install.packages("lmtest")
library(lmtest)
dwtest(m)  # p-value 0.09522로 귀무가설 기각할 수 없으므로, autocorrelation이 0인 것(오차 간의 상관관계가 없는 것)으로 결론




# <로지스틱 회귀>
# 1. 이진 분류 문제 데이터 준비 from iris
data("iris")
str(iris)
table(iris$Species)

d = subset(iris, Species %in% c('versicolor', 'virginica'))
str(d)

# 2. 전체 변수(.)를 사용해 로지스틱 회귀분석 실시
## 주의 : y변수가 factor 타입이어야 함
m = glm( Species ~ . , data = d , family = 'binomial')
m
summary(m)

fitted(m)[c(1:5, 51:55)]  # vegicolor(1~50번째)는 0에 가깝게, virginica(51~100번째)는 1에 가깝게 예측한 것을 확인할 수 있음

str(d$Species)  # factor - versicolor(2), virginica(3)
str(as.numeric(d$Species))  # num 2 or 3

f = fitted(m)  # 0~1 사이의 값 (해당 레코드가 virginica일 확률)
is_correct = ifelse( f > .5, 1, 0 ) == ( as.numeric(d$Species) - 2 )
sum(is_correct)

as.numeric(d$Species)-1


?glm
?fitted


