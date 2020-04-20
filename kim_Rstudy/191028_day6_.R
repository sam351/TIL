?read.csv
search()
installed.packages()
read_excel()  # error

# readxl 패키지 설치 및 사용
# install.packages("readxl")
library(readxl)

excel_data <- read_excel('book/data_ex.xls')
View(excel_data)


# 데이터 저장&불러오기
data_ex <- data.frame(head(excel_data, 5))
data_ex <- data_ex[1:2]

save(data_ex, file = "data_ex.rda")
rm(data_ex)
load("data_ex.rda")
data_ex

write.csv(data_ex, file = "data_ex.csv")
write.table(data_ex, file = "data_ex.txt")


