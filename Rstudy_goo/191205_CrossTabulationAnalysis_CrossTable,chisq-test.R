# < 교차분석 >
data <- read.csv('data/Part-III/cleanDescriptive.csv')
head(data)
str(data)

x <- data$level2  # 부모의 학력수준 추출
y <- data$pass2  # 학생의 (대학) 합격/실패 여부 추출
table(x, y)

library(gmodels)  # CrossTable()
CrossTable(x, y, chisq = T)
chisq.test(matrix(table(x,y), ncol=2))


# + gmodels::CrossTable() 활용해 ggplot2::diamond 분포표 생성
library(ggplot2)  # diamond dataset
data("diamonds")
head(diamonds)

table(diamonds$color, diamonds$cut)
CrossTable(diamonds$color, diamonds$cut, chisq = T)
?CrossTable  # 각 칸의 5개의 값들은 각각 빈도, 카이제곱 기대비율??, 행 기준 상대도수, 열 기준 상대도수, 전체 기준 상대도수 의미


(40-35.244)^2/35.244
