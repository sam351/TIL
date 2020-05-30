# 데이터 시각화

# plot( ) - 산포도
rainbow(5)  # 색상 벡터 리턴

국어<- c(4,7,6,8,5,5,9,10,4,10)  
plot(국어)

plot(국어, type="o", col="blue")       
title(main="성적그래프", col.main="red", font.main=4) 


국어 <- c(4,7,6,8,5,5,9,10,4,10)
수학 <- c(7,4,7,3,8,10,4,10,5,7)

plot(국어, type="o", col="blue") + 
  lines(수학, type="o", pch=16, lty=2, col="red") +
  title(main="성적그래프", col.main="red", font.main=4)

par(mar=c(1,1,1,1), mfrow=c(4,2))  # parameter setting
plot(국어, type="p", col="blue", main="type = p") + 
  plot(국어, type="l", col="blue", main="type = l") + 
  plot(국어, type="b", col="blue", main="type = b") + 
  plot(국어, type="c", col="blue", main="type = c") + 
  plot(국어, type="o", col="blue", main="type = o") + 
  plot(국어, type="h", col="blue", main="type = h") + 
  plot(국어, type="s", col="blue", main="type = s", xaxt="n", yaxt="n") + 
  plot(국어, type="S", col="blue", main="type = S", xaxt="n", yaxt="n")

par(mar=c(5,5,5,5), mfrow=c(1,1))  # parameter 초기화
plot(국어, type="o", col="blue", ylim=c(0,10), axes=FALSE, ann=FALSE)  # axes로 x&y 축 삭제, ann으로 x&y 라벨 삭제

# x, y 축 추가하기
axis(1, at=1:10, lab=c("01","02","03","04", "05","06","07","08","09","10")) # x축 추가
axis(2, at=c(0,2,4,6,8,10))  # y축 추가

# 그래프 추가하고, 그래프에 박스 그리기
lines(수학, type="o", pch=16, lty=2, col="red")    
box()   # 박스 그리기

# 그래프 제목, 축의 제목, 범례 나타내기
title(main="성적그래프", col.main="red", font.main=4) 
title(xlab="학번", col.lab=rgb(0,1,0))
title(ylab="점수", col.lab=rgb(1,0,0)) 
legend(7, 3, c("국어","수학"),
       cex=0.8, col=c("blue","red"),
       pch=c(21,16), lty=c(1,2))  


(성적 <- read.table("data/성적.txt", header=TRUE));

plot(성적$학번, 성적$국어,
       main="성적그래프", xlab="학번", ylab="점수",
       xlim=c(0, 11), ylim=c(0, 11)) 

ymax <- max(성적[3:5]) #성적 데이터 중에서 최대값을 찾는다(y 축의 크기 제한)
ymax
pcols<- c("red","blue","green")

# 시각화 결과 그림파일 저장하기
png(filename="성적.png", height=400, width=700, bg="white") # 출력을 png파일로 설정

plot(성적$국어, type="o", col=pcols[1], ylim=c(0, ymax), axes=FALSE, ann=FALSE)

axis(1, at=1:10, lab=c("01","02","03","04","05","06","07","08","09","10"))
axis(2, at=c(0,2,4,6,8,10), lab=c(0,2,4,6,8,10))
box()
lines(성적$수학, type="o", pch=16, lty=2, col=pcols[2])
lines(성적$영어, type="o", pch=23, lty=3, col=pcols[3] )
title(main="성적그래프", col.main="red", font.main=4)
title(xlab="학번", col.lab=rgb(1,0,0))
title(ylab="점수", col.lab=rgb(0,0,1))
legend(7, 3, names(성적)[c(3,4,5)], 
       cex=0.8, col=pcols, 
       pch=c(21,16,23), lty=c(1,2,3))

dev.off()


plot(국어, 수학)
plot(수학~국어)





# 막대 그래프
barplot(국어)

coldens <- seq(from=10, to=100, by=10)   # 막대그래프의 색밀도 설정을 위한 벡터
xname <- 성적$학번  # X 축 값 설정위한  벡터

barplot(성적$국어, 
          main="성적그래프", xlab="학번", ylab="점수",
          border="red", col="green", 
          density=coldens, names.arg=xname)

# 학생의 각 과목에 대한 각각의 점수에 대한 그래프
성적1<- 성적[3:5] 
str(성적1)

barplot(as.matrix(성적1),
        main="성적그래프", beside=T,
        ylab="점수", col=rainbow(10))
barplot(as.matrix(성적1), 
        main="성적그래프", ylab="점수", 
        col=rainbow(10))
barplot(t(성적1), 
        main="성적그래프", ylab="점수",
        col=rainbow(10))

# 학생의 각 과목에 대한 합계 점수에 대한 그래프
xname <- 성적$학번;    #  x축 레이블용 벡터
par(mar=c(5,5,5,5), mfrow=c(1,1))  # parameter 초기화
par(xpd=T, mar=par()$mar+c(0,0,0,4));   # 우측에 범례가 들어갈 여백을 확보
barplot(t(성적1), 
        main="성적그래프", ylab="점수", 
        col=rainbow(3), space=0.1,
        names.arg=xname, 
        cex=0.8, cex.axis=0.8)
legend(11,30, names(성적1), cex=0.8, fill=rainbow(3))


# 학생의 각 과목에 대한 합계 점수에 대한 그래프(가로막대 그래프)
barplot(t(성적1), 
        main="성적그래프", ylab="학번", 
        col=rainbow(3), space=0.1,
        cex.axis=0.8, cex=0.8, 
        names.arg=xname, horiz=T) +
  legend(30,11, names(성적1), cex=0.8, fill=rainbow(3))





# 파이그래프
(성적 <- read.table("data/성적.txt", header=TRUE));
pie(성적$국어,
      labels=paste(성적$성명,"\n","(",성적$국어,")"),
      col=rainbow(10))

pie(성적$국어, 
      labels=paste(성적$성명, "-", 성적$국어), 
      col=rainbow(10))

## 시계방향 나열 (기본값 : 반시계방향)
pie(성적$국어, 
      clockwise=T, 
      labels=paste(성적$성명, "-", 성적$국어), 
      col=rainbow(10))

## 시계방향 나열, density로 빗금(밀도) 처리
pie(성적$국어,
      clockwise=T, 
      labels=paste(성적$성명, "-", 성적$국어), 
      col=rainbow(10), density=10)

## 제목 설정하고, 각진 모양 설정(기본값 : 원)
pie(성적$국어, 
      labels=paste(성적$성명, "-", 성적$국어), 
      col=rainbow(10), 
      main="국어성적", edges=10)

## 1을 24개 가진 벡터를 24가지 색의 파이차트로 시각화
pie(rep(1, 24), col = rainbow(24), 
    radius = 1.5)





(성적 <- read.table("data/성적.txt", header=TRUE))

# 히스토그램
hist(성적$국어, breaks=5, 
       main="성적분포-국어", xlab="점수", 
       col = "lightblue", border = "pink")
hist(성적$수학,
       main="성적분포-수학", xlab="점수",
       col = "lightblue", border = "pink")
hist(성적$국어, 
       main="성적분포-국어", xlab="점수", ylab="도수", 
       col=rainbow(12), border = "pink")

nums <- sample(1:100, 30)
hist(nums)

hist(nums, 
     breaks=c(0,10,20,30,40,50,60,70,80,90,100))

hist(nums, 
     breaks=c(0,50,100))

## 지정된 bin 간격이 일정하지 않으면, probability 파라메터가 자동으로 T가 됨
hist(nums, 
     breaks=c(0,33,66,100))


(score <- sample(0:100, 30))
barplot(score)
hist(score)
hist(score, breaks=10)
hist(score, breaks=2) #?
hist(score, breaks=3) #? 
hist(score, breaks=4) #? 
hist(score, breaks=5) #?
hist(score, breaks=6) #? 
hist(score, breaks=7) #? 
hist(score, breaks=8) #? 
hist(score, breaks=9) #? 
hist(score, breaks=c(0,20,30,40,50,100))


hist(성적$국어, 
       main="성적분포-국어", xlab="점수", ylab="학생수",
       col=rainbow(12), border = "pink")
hist(성적$국어,
       main="성적분포-국어", xlab="점수", ylab="도수", 
       col=rainbow(12), border = "pink",prob=T)
## 추세선 추가
lines(density(성적$국어, bw=0.5), 
      col="red", lwd=3)
lines(density(성적$국어, bw=1.0), 
      col="blue", lwd=3)





# 박스플롯
summary(성적$국어)
boxplot(성적$국어, col="yellow",  ylim=c(0,10), xlab="국어", ylab="성적")

성적2 <- 성적[,3:5]
boxplot(성적2, 
          col=rainbow(3), ylim=c(0,10), ylab="성적")


data <- read.table("data/온도.txt", header=TRUE, sep=",")
str(data)
head(data, n=5)
boxplot(data)

boxplot(data, las = 2)

boxplot(data, las = 2, 
        at = c(1,2,3,4, 6,7,8,9, 11,12,13,14))

## 반복되는 색 패턴 지정하기
chtcols = rep(c("red", "sienna", 
                "palevioletred1", "royalblue2"), 
              times=3); chtcols
boxplot(data, las = 2, 
        at = c(1:4, 6:9, 11:14),
        col=chtcols)
grid(col="gray", lty=2, lwd=1)


n=5
rainbow(n)
heat.colors(n)
terrain.colors(n)
topo.colors(n)
cm.colors(n)
gray.colors(n)





# ggplot2
install.packages("ggplot2")
library(ggplot2)
library(dplyr)
search()  # the list of attached packages
data(airquality)  # Loads specified data sets, or list the available data sets
str(airquality)

## 기본 예제
ggplot(airquality, aes(x=Day, y=Temp))

ggplot(airquality, aes(x=Day, y=Temp)) + 
  geom_point()

ggplot(airquality, aes(x=Day, y=Temp)) + 
  geom_point(size=3, color="red")

ggplot(airquality, aes(x=Day, y=Temp)) + 
  geom_line()

ggplot(airquality, aes(x=Day, y=Temp)) + 
  geom_line() + 
  geom_point()

ggplot(airquality, aes(x=Day, y=Temp)) + 
  geom_line(color="green") + 
  geom_point(size=3)


## 
str(mtcars)
?mtcars

table(mtcars$cyl)

ggplot(mtcars, aes(x=cyl)) +
  geom_bar()

ggplot(mtcars, aes(x=cyl)) + 
  geom_bar(width=0.5)

ggplot(mtcars, aes(x=factor(cyl))) + 
  geom_bar()

ggplot(mtcars, aes(x=factor(cyl))) + 
  geom_bar(width=0.5)

ggplot(mtcars, aes(x=factor(cyl))) + 
  geom_bar(aes(fill=factor(gear)), alpha=0.3)

ggplot(mtcars, aes(x=factor(cyl))) + 
  geom_bar(aes(fill=factor(gear))) + 
  coord_polar()

ggplot(mtcars, aes(x=factor(cyl))) + 
  geom_bar(aes(fill=factor(gear))) + 
  coord_polar(theta='y')

ggplot(airquality, aes(x=Day, y=Temp, group=Day)) +
  geom_boxplot()

ggplot(airquality, aes(Temp)) + 
  geom_histogram()


## 테마별 변화 확인
ggplot(mtcars, aes(x=gear)) +
  geom_bar() + 
  labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") + 
  theme_gray()

ggplot(mtcars, aes(x=gear)) + 
  geom_bar() + 
  labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") +
  theme_bw()

ggplot(mtcars, aes(x=gear)) +
  geom_bar() + 
  labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") +
  theme_linedraw()

ggplot(mtcars, aes(x=gear)) + 
  geom_bar() + 
  labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") +
  theme_light()

ggplot(mtcars, aes(x=gear)) + 
  geom_bar() + 
  labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") +
  theme_dark()

ggplot(mtcars, aes(x=gear)) + 
  geom_bar() + 
  labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") +
  theme_minimal()

ggplot(mtcars, aes(x=gear)) + 
  geom_bar() + 
  labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") +
  theme_classic()

ggplot(mtcars, aes(x=gear)) + 
  geom_bar() + 
  labs(x="기어수", y="자동차수", title="변속기 기어별 자동차수") +
  theme_void()


## 변수 활용해 플로팅 시 반복 줄이기
imsi <- ggplot(mtcars, aes(x=gear)) +
  geom_bar() + 
  labs(x="기어수", y="자동차수", 
       title="변속기 기어별 자동차수")

imsi + theme_gray()
imsi + theme_bw()
imsi + theme_linedraw()
imsi + theme_light()
imsi + theme_dark()
imsi + theme_minimal()
imsi + theme_classic()
imsi + theme_void()


## xlim, ylim in ggplot2
mpg <- as.data.frame(ggplot2::mpg)
str(mpg)
# x축 displ, y축 hwy로 지정해 배경 생성
ggplot(data = mpg, aes(x = displ, y = hwy))
# 배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point()
ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + xlim(3, 6)
ggplot(data = mpg, aes(x = displ, y = hwy)) +   
  geom_point() +  
  xlim(3, 6) +  ylim(10, 30)





# reading excel file (.xlsx)
install.packages("xlsx")
library(xlsx)
classDF <- read.xlsx("data/data.xlsx", 1, encoding="UTF-8")
str(classDF)
View(classDF)

bar_data <- classDF[3]
bar_data
ggplot(bar_data, aes(x=bloodType)) + 
  geom_bar()

ggplot(classDF, aes(x=bloodType, fill=gender)) + 
  geom_bar()





# A, B회사의 매출 실적 데이터프레임 만들기
company <- c('A', 'A', 'A', 'A', 'B', 'B', 'B', 'B')
year <- c('1980', '1990', '2000', '2010', '1980', '1990', '2000', '2010')
sales <- c(2750, 2800, 2830, 2840, 2760, 2765, 2775, 2790)

coSalesDF <- data.frame(company, year, sales)

# 생성된 coSalesDF 확인
coSalesDF
str(coSalesDF)
#-------------------------------------------------------------

# 라인차트 생성 - x축은 연도(year), y축은 매출(sales) 매칭
ggplot(coSalesDF, aes(x=year, y=sales)) + 
  geom_line(aes(group=company))

#-------------------------------------------------------------
# 선 색상 및 두께 설정
ggplot(coSalesDF, aes(x=year, y=sales)) + 
  geom_line(size=2, aes(group=company,colour=company))

#-------------------------------------------------------------
ggplot(coSalesDF, aes(x=year, y=sales)) + 
  geom_line(size=2, aes(group=company, colour=company)) + 
  geom_point(size=2)





# 빈도 막대 그래프
ggplot(data = mpg, aes(x = drv)) + 
  geom_bar()

# 선 그래프
ggplot(data = economics, aes(x = date, y = unemploy)) + 
  geom_line()

# 상자 그림
ggplot(data = mpg, aes(x = drv, y = hwy)) + 
  geom_boxplot()



