
# 1
searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode(iconv("단풍","euc-kr","UTF-8"))
url <- paste(searchUrl, "?query=", query, "&display=100", sep="")
doc <- GET(url, add_headers('X-Naver-Client-Id' = Client_ID, 'X-Naver-Client-Secret' = Client_Secret))

doc1 <- htmlParse(doc, encoding="UTF-8")
text1 <- xpathSApply(doc1, "//item/description", xmlValue)

text1 <- gsub("[</b>[:cntrl:]]","",text1)
text1 <- trimws(text1)

write(text1, "naverblog.txt")



# 2
searchUrl <- "https://openapi.naver.com/v1/search/news.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode(iconv("빅데이터","euc-kr","UTF-8"))
url <- paste(searchUrl, "?query=", query, "&display=100", sep="")
doc <- GET(url, add_headers('X-Naver-Client-Id' = Client_ID, 'X-Naver-Client-Secret' = Client_Secret))

doc1 <- htmlParse(doc, encoding="UTF-8")
text1 <- xpathSApply(doc1, "//item/title", xmlValue)

text1 <- gsub("[</b>[:cntrl:]&quot;]","",text1)
text1 <- trimws(text1)

write(text1, "navernews.txt")



# 3
api_key <- "gjUkHgO8bFmNobRk4g0Jas8xb"
api_secret <- "loF0mtnzLhtQDFjahdRHox6wcR1fiD6Fw95DP5QCSy3rLTTP1K"
access_token <- "607145164-8L5HtzopZzhjuBCgusUGKE3MHOa9P4RbmhUrM0E1"
access_token_secret <- "2wn2bsCA7JIH5DZ5Ss1deS5BNLabzaX2xSpM2ZLMIqwQf"
setup_twitter_oauth(api_key,api_secret, access_token,access_token_secret)

key <- "취업"
key <- enc2utf8(key)

result <- searchTwitter(key, n=100)
DF <- twListToDF(result)
content <- DF$text

content <- gsub("[[:lower:][:upper:][:digit:][:punct:][:cntrl:]]", "", content)   
content <- trimws(content)

write(content, "twitter.txt")



# 4
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "360"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")

doc <- xmlParse(url, encoding="UTF-8")
top <- xmlRoot(doc)
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))

cat("노선ID :", as.character(df$busRouteId[1]), "\n");
cat("노선길이 :", as.character(df$length[1]), "\n");
cat("기점 :", as.character(df$stStationNm[1]), "\n");
cat("종점 :", as.character(df$edStationNm[1]), "\n");
cat("배차간격 :", as.character(df$term[1]), "\n\n")


