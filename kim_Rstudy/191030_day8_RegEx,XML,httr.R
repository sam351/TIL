# RegEx
word <- "JAVA javascript Aa 가나다 AAaAaA123 %^&*"
gsub("A","",word)
gsub("Aa","",word)
gsub("(Aa)","",word)  # A와 a가 묶인 문자열 (윗줄과 동일)
gsub("(Aa){2}","",word)  # (Aa)가 2번 반복되는 문자열
gsub("[Aa]","",word)  # A 또는 a인 문자열
gsub("[가-힣]","",word)  # 한글인 문자열
gsub("[^가-힣]","",word)  # 한글이 아닌 문자열
gsub("[&^%*]","",word)
gsub("[[:punct:]]","",word)
gsub("[[:alnum:]]","",word)  # 숫자 또는 문자인 문자열
gsub("[1234567890]","",word)  # 숫자인 문자열
gsub("[0-9]","",word)  # 숫자인 문자열
gsub("\\d","",word)  # 숫자인 문자열
gsub("[[:digit:]]","",word)  # 숫자인 문자열
gsub("[^[:alnum:]]","",word)  # 숫자 또는 문자이 아닌 문자열
gsub("[[:space:]]","",word)  # 공백인 문자열


# 한국일보 홈페이지 크롤링 (XML 패키지)
# install.packages("XML")
library(XML)
library(rvest)
imsi <- read_html("https://www.hankookilbo.com/")

t <- htmlParse(imsi)
content <- xpathSApply(t, "//p[@class='title']", xmlValue); content  # xpath로 "p[@class='title']"는 css 선택자로 "p.title"

content <- gsub("[[:punct:][:cntrl:]]","", content); content
content <- trimws(content); content
length(content)  # 35개
content <- unique(content); content
length(content)  # 26개

class(imsi)
class(t)
class(content)

?htmlParse
?xpathSApply
?xmlValue
?xmlGetAttr
?xmlAttrs

?trimws
?unique


# httr 패키지 사용 - GET 방식 요청
# install.packages("httr")
library(httr)
http.standard <- GET("http://www.w3.org/Protocols/rfc2616/rfc2616.html")
title2 <- html_nodes(read_html(http.standard), 'div.toc h2')

str(http.standard$content)
?GET


# httr 패키지 사용 - POST 방식 요청
game <- POST("http://www.gevolution.co.kr/score/gamescore.asp?t=3&m=0&d=week",
             encode = 'form', body = list(txtPeriodW = "2019-10-5"))
title2 <- html_nodes(read_html(game), 'a.tracktitle')
title2 <- html_text(title2)
title2[1:10]

?POST


# 이미지, 첨부파일 다운 받기
# pdf
res <- GET("http://cran.r-project.org/web/packages/httr/httr.pdf")
writeBin(content(res, 'raw'), 'c:/Temp/httr.pdf')

# jpg
h <- read_html("http://unico2013.dothome.co.kr/productlog.html")
imgs <- html_nodes(h, 'img')
img.src <- html_attr(imgs, 'src')
for (i in 1:length(img.src)) {
  res <- GET( paste0("http://unico2013.dothome.co.kr/", img.src[i]) )
  writeBin(content(res, 'raw'), paste0('c:/TEMP/', img.src[i]))
}

?writeBin
?content
