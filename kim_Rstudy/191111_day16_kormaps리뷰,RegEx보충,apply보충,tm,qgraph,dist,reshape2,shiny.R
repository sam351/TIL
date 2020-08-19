# '특정 구만 지도 시각화' 예제 소스코드
library(Kormaps)
data(korpopmap2)
data(korpopmap3)
Encoding(korpopmap2@data$name) <- 'UTF-8'
korpopmap2@data$code.data
korpopmap2@data$name
gucodename <- korpopmap2@data[,c("name", "code.data")]

names(gucodename)
Encoding(korpopmap3@data$name) <- 'UTF-8'
korpopmap3@data$code.data
korpopmap3@data$name

guname <- '강남구'
gucode <- gucodename[gucodename$name == guname,
                     "code.data"]
pattern <- paste0('^', gucode)
korpopmap3@data[grep(pattern,
                     korpopmap3@data$code.data), 
                c("code.data", "name")]





# 정규표현식 보충
gsub("ABC", "***", "ABCabcABC")  #ABC를 **로 변환
gsub("ABC", "***", "ABCabcABC", ignore.case=T)  #대소문자 구분 없이 변환

x <- c("ABCabcABC", "abcABCabc")
gsub("ABC", "***", x)  #벡터 내의 문자열 변환

gsub("b.n", "***", "i love banana")  # b와 n 사이에 임의의 문자열이 점(.) 개수만큼 존재하는 패턴만 변경
gsub("b.*n", "***", "i love banana")   # b와 n 사이에 임의의 문자열이 몇 개든 상관없이 존재하는 패턴만 변경
gsub("[bn]a", "***", "i love banana")  # b 또는 n 뒤에 a 존재하는 패턴만 변경
gsub("010-[0-9]{4}-[0-9]{4}", 
     "010-****-****", 
     "내 폰번호는 010-1234-6789")  # [0-9]{n} : 0~9사이의 기호가 n번 나오는 패턴 / [0-9]{m,n} : 0~9사이의 기호가 최소 m번 최대 n번 나오는 패턴
gsub("010-\\d{4}-\\d{4}", 
     "010-****-****", 
     "내 폰번호는 010-1234-6789")  # 위와 동일한 기능
gsub(" +", " ", "i   love    banana")  # 공백이 2 이상인 패턴만 공백 하나로 변경





# apply 계열 함수들 보충
weight <- c(65.4, 55, 380, 72.2, 51, NA)
height <- c(170, 155, NA, 173, 161, 166)
gender <- c("M", "F", "M", "M", "F", "F")

df <- data.frame(w=weight, h=height)
df

apply(df, 1, sum, na.rm=TRUE)  # df의 가로줄(행)끼리 sum 적용
apply(df, 2, sum, na.rm=TRUE)  # df의 세로줄(열)끼리 sum 적용

lapply(df, sum, na.rm=TRUE)  # 열끼리 sum 적용해 list 리턴
sapply(df, sum, na.rm=TRUE)  # 열끼리 sum 적용해 가급적 simple한 형태로 리턴(리스트, 벡터 등)

tapply(df$w, gender, mean, na.rm=TRUE)  # gender라는 팩터를 기준으로 그룹핑해 각각 mean 적용
tapply(1:6, gender, sum, na.rm=TRUE)
mapply(paste, 1:5, LETTERS[1:5], month.abb[1:5])  # multiple apply - 몇 개가 되었든 주어진 벡터들의 일치하는 순서 원소끼리 함수 적용

## self-defined 함수 apply에 적용해보기
count <- 1
myf <- function(x, wt=T){
  print(paste(x,"(",count,")"))
  Sys.sleep(1)
  if(wt) 
    r <- paste("*", x, "*")
  else
    r <- paste("#", x, "#")
  count <<- count + 1;
  return(r)
}

sapply(df$w, myf)
sapply(df$w, myf, F)
sapply(df$w, myf, wt=F)
rr1 <- sapply(df$w, myf, wt=F)
str(rr1)

count <- 1
sapply(df, myf)
rr2 <- sapply(df, myf)
str(rr2)

rr2[1,1]
rr2[1,"w"]

r <- sapply(df, myf)
str(r)





# tm 패키지 - 텍스트마이닝 전용 패키지
library(KoNLP)
library(wordcloud)
library(RColorBrewer)
library(stringr)
useSejongDic()
install.packages("tm")
library(tm)

lunch <- c("커피 파스타 치킨 샐러드 아이스크림",
           "커피 우동 소고기김밥 귤",
           "참치김밥 커피 오뎅",
           "샐러드 피자 파스타 콜라",
           "티라무슈 햄버거 콜라",
           "파스타 샐러드 커피")

cps <- VCorpus(VectorSource(lunch))
tdm <- TermDocumentMatrix(cps)
tdm
as.matrix(tdm)

cps <- VCorpus(VectorSource(lunch))
tdm <- TermDocumentMatrix(cps, 
                          control = 
                            list(wordLengths = c(1, Inf)))
tdm
(m <- as.matrix(tdm))

colnames(m) <- c("doc1", "doc2", "doc3", "doc4", "doc5", "doc6")
rowSums(m)
colSums(m)


com <- m %*% t(m)  # m과 m전치행렬의 행렬곱
com





# 행렬곱 시각화 - qgraph 패키지
install.packages("qgraph")
library(qgraph)

qgraph(com, labels=rownames(com), diag=F, 
       layout='spring',  edge.color='blue', 
       vsize=log(diag(com)*800))





# proxy 패키지 - dist 함수
install.packages("proxy")
library(proxy)
dd <- NULL
d1 <- c("aaa bbb ccc")
d2 <- c("aaa bbb ddd")
d3 <- c("aaa bbb ccc")
d4 <- c("xxx yyy zzz")
dd <- c(d1, d2, d3, d4)
cps <- Corpus(VectorSource(dd))

dtm <- DocumentTermMatrix(cps)
as.matrix(dtm)

inspect(dtm)  # dtm 객체 정보와 매트릭스 결과 동시에 출력

m <- as.matrix(dtm)
com <- m %*% t(m)
com  # doc 간의 유사성 매트릭스

## 행렬곱(유사성) 매트릭스 각 요소 간의 distance 계산
dist(com, method = "cosine")
dist(com, method = "Euclidean")

## 코싸인 직접 계산 - lsa 패키지 cosine 함수
install.packages("lsa")
library(lsa)
cosine(com)





# Install
install.packages("tm")  # 텍스트 마이닝을 위한 패키지
install.packages("SnowballC") # 어간추출을 위한 패키지
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes
# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")


filePath <- "http://www.sthda.com/sthda/RDoc/example-files/martin-luther-king-i-have-a-dream-speech.txt"
text <- readLines(filePath)

# VectorSource () 함수는 문자형 벡터 모음을 만듭니다.
docs <- Corpus(VectorSource(text))
# 텍스트의 특수 문자 등을 대체하기 위해 tm_map () 함수를 사용하여 변환이 수행됩니다.
# “/”,“@”및“|”을 공백으로 바꿉니다.
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")


# 소문자로 변환
docs <- tm_map(docs, content_transformer(tolower))
# 수치 데이터 제거
docs <- tm_map(docs, removeNumbers)
# 영어 불용어(문서에서 의미없다고 판단되는 기호들) 제거
docs <- tm_map(docs, removeWords, stopwords("SMART"))

# 벡터 구조로 사용자가 직접 불용어  설정 , 제거
docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 

# 문장 부호 punctuations
docs <- tm_map(docs, removePunctuation)

# 공백 제거
docs <- tm_map(docs, stripWhitespace)

# 텍스트 형태소 분석
# docs <- tm_map(docs, stemDocument)

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)

wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))





# reshape2
install.packages("reshape2")
library(reshape2)

head(french_fries)
# time : 몇 주차 실험인가
# treatment : 사용한 식용유의 종류
# subject : 실험 대상자
# rep : 이 측정이 몇 번째 반복인가
# potato : 감자 맛
# buttery : 버터 맛
# grassy : 풀맛
# rancid : 신맛
# painty : 안 좋은 냄새

# 문제 : potato 열의 평균, buttery 열의 평균, grassy 열의 평균, rancid 의 평균, painty 의 평균을 구하시오.
str(french_fries)
mean(french_fries$potato, na.rm = T)

colnames(french_fries)
apply(french_fries[5:9], 2, mean, na.rm=T)


## reshape2 패키지 활용한 문제 풀이
m <- melt(french_fries, id.vars=1:4)
head(m)

library(dplyr)
m %>% 
  group_by(variable) %>% 
  summarize(평균=mean(value, na.rm=T))

m2 <- melt(french_fries, id.vars=1:4, na.rm=T)
dim(m)
dim(m2)
m2 %>% 
  group_by(variable) %>% 
  summarize(평균=mean(value))

r <- dcast(m, time+treatment+subject+rep ~ ...)
head(r)
head(french_fries)

rownames(r) <- NULL
rownames(french_fries) <- NULL

identical(r, french_fries)


## 책에 있는 예제들
str(airquality)
dim(airquality)
View(airquality)
names(airquality)

names(airquality) <- tolower(names(airquality))
head(airquality)
names(airquality)

melt_test <- melt(airquality)
dim(melt_test)
melt_test2 <- melt(airquality, id.vars=c("month", "wind"), measure.vars="ozone")
head(melt_test2)
dim(melt_test2)

melt_test3 <- melt(airquality, id.vars=c("month", "wind"))
head(melt_test3)
dim(melt_test3)

aq_melt <- melt(airquality, id.vars=c("month", "day"), na.rm=T)
dim(aq_melt)
aq_dcast <- dcast(aq_melt, month+day ~ variable)
View(airquality); 
View(aq_melt); 
View(aq_dcast); 
dcast(aq_melt, month~variable, mean)





# 