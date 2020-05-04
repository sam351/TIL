library(httr)
library(XML)
library(rvest)

# 네이버 open api 사용해 블로그 검색 결과 크롤링하기
searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

# URLencode("여름추천요리")
query <- URLencode(iconv("여름추천요리", from="euc-kr", to="UTF-8"))
query
url <- paste(searchUrl, "?query=", query, "&display=20", sep="")

doc <- GET(url, add_headers('Content-Type' = "application/xml", 'X-Naver-Client-Id' = Client_ID, 'X-Naver-Client-Secret' = Client_Secret))

# response의 내용 파싱 방법1
doc1 <- htmlParse(doc, encoding="UTF-8")
text1 <- xpathSApply(doc1, "//item/description", xmlValue)
text1

# response의 내용 파싱 방법2
doc2 <- html_nodes(read_html(doc, encoding="UTF-8"), xpath='//item/description')
text2 <- html_text(doc2)
text2

# response의 내용 파싱 방법3
doc3 <- html_nodes(content(doc, encoding="UTF-8"), xpath='//item/description')
text3 <- html_text(doc3)
text3


?iconv
?URLencode
?add_headers
?htmlParse
?content



# 네이버 open api 사용해 뉴스 검색 결과 크롤링하기
searchUrl<- "https://openapi.naver.com/v1/search/news.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode(iconv("검찰","euc-kr","UTF-8"))
url<- paste(searchUrl, "?query=", query, "&display=20", sep="")

doc<-GET(url, add_headers('Content-Type' = "application/xml", 'X-Naver-Client-Id' = Client_ID, 'X-Naver-Client-Secret' = Client_Secret))

paringData <- htmlParse(doc, encoding="UTF-8")
text<- xpathSApply(paringData, "//item/description", xmlValue)
text

xpathSApply(paringData, "//item/title", xmlValue)



# 트위터 글 읽어오기
# install.packages("twitteR")
library(twitteR) 
api_key <- "gjUkHgO8bFmNobRk4g0Jas8xb"
api_secret <- "loF0mtnzLhtQDFjahdRHox6wcR1fiD6Fw95DP5QCSy3rLTTP1K"
access_token <- "607145164-8L5HtzopZzhjuBCgusUGKE3MHOa9P4RbmhUrM0E1"
access_token_secret <- "2wn2bsCA7JIH5DZ5Ss1deS5BNLabzaX2xSpM2ZLMIqwQf"

setup_twitter_oauth(api_key,api_secret, access_token,access_token_secret)

# oauth 정보 저장 확인
key <- "단풍"
key <- enc2utf8(key)

result <- searchTwitter(key, n=100)
DF <- twListToDF(result)
str(DF)
content <- DF$text
content <- gsub("[[:lower:][:upper:][:digit:][:punct:][:cntrl:]]", "", content)   
content

?setup_twitter_oauth
?enc2utf8
?searchTwitter
?twListToDF



# 공공데이터포털 open api 사용해 버스정보 크롤링하기
library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "402"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")

doc <- xmlParse(url, encoding="UTF-8")
top <- xmlRoot(doc)
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
View(df)
str(df)

busRouteId <- df$busRouteId; busRouteId
url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")

doc <- xmlParse(url, encoding="UTF-8")
top <- xmlRoot(doc)
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
View(df)


?xmlParse
?xmlRoot
?getNodeSet
?xmlToDataFrame



# 셀레늄으로 구글에서 'JAVA' 검색결과 불러오기
# install.packages("RSelenium")
library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")

remDr$open()
remDr$navigate("http://www.google.com/ncr")

webElem <- remDr$findElement(using="css", "[name='q']")
webElem$sendKeysToElement(list("JAVA", key="enter"))


?remoteDriver
?remDr$open
?remDr$navigate
?remDr$findElement
?webElem$sendKeysToElement



# 셀레늄으로 네이버에서 검색결과 불러오기
remDr$navigate("http://www.naver.com")

webElem <- remDr$findElement(using="css", "#query")
webElem$sendKeysToElement(list("JAVA", key="enter"))



# 셀레늄으로 네이버 웹툰에서 댓글 불러오기
remDr$navigate("https://comic.naver.com/comment/comment.nhn?titleId=570503&no=135")

# 여러 개 클릭(사실은 하나)
more <- remDr$findElements(using="css", "span.u_cbox_in_view_comment")
class(more)
sapply(more, function(x){x$clickElement()})

# 한 개만 클릭
more <- remDr$findElement(using="css", "span.u_cbox_in_view_comment")
class(more)
more$clickElement()

# 페이지 이동 클릭
btn <- remDr$findElement(using = "css" ,"div.u_cbox_paginate > div > a:nth-child(4)")
btn$clickElement()

btn <- remDr$findElement(using = "css" ,"div.u_cbox_paginate > div > a:nth-child(5)")
btn$clickElement()

btn <- remDr$findElement(using = "css" ,"div.u_cbox_paginate > div > a:nth-child(13)")
btn$clickElement()

btn <- remDr$findElement(using = "css" ,"a.u_cbox_next.u_cbox_next_end")
btn$clickElement()

# 페이지 이동 클릭 - 반복문 사용
for (idx in 4:12) {
  nextCss <- paste0( "div.u_cbox_paginate > div > a:nth-child(", idx, ")" )
  nextPage <- remDr$findElement(using = 'css', nextCss)
  nextPage$clickElement()
  Sys.sleep(1)
}


?nextPage$clickElement
?Sys.sleep
