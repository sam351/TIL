library(httr)
library(XML)
library(rvest)
library(RSelenium)

# 셀레늄 기본 실습
driver <- remoteDriver(port=4445, browserName="chrome")
# class(driver)
# str(driver)
# driver

driver$open()
driver$navigate("http://www.google.com")

webElem <- driver$findElement(using = "css", value = "div.RNNXgb  div.a4bIc > input")
# class(webElem)
# str(webElem)
# webElem

webElem$getElementTagName()
webElem$sendKeysToElement(sendKeys = list("JAVA", key="enter"))



# 셀레늄 실습 - 네이버 웹툰 베스트 댓글 출력
driver <- remoteDriver(port=4445, browserName="chrome")
driver$open()

url <- "https://comic.naver.com/comment/comment.nhn?titleId=570503&no=135"
driver$navigate(url)

bestReviewNodes <- driver$findElements(using = "css", value = "ul.u_cbox_list span.u_cbox_contents")
sapply(X = bestReviewNodes, FUN = function(x){ x$getElementText() })

# getElementTagName()으로 정상적으로 불러왔는지 확인
bestReviewNodes[[1]]$getElementTagName()
for (tag in bestReviewNodes) {
  cat(tag$getElementTagName()[[1]], '\t')
}



# 셀레늄 실습 - 네이버 웹툰 전체 댓글 1페이지 출력
driver$open()
driver$navigate("https://comic.naver.com/comment/comment.nhn?titleId=570503&no=135")

total_btn <- driver$findElement(using = "css", value = "span.u_cbox_sort_label")
total_btn$clickElement()

totalReview_nodes <- driver$findElements(using = "css", value = "span.u_cbox_contents")
# length(totalReview_nodes) → 15개로 정상 확인
sapply(totalReview_nodes, function(x) { x$getElementText() })



?remoteDriver
?remDr$open
?remDr$navigate
?remDr$findElement

?webElem$getElementTagName
?webElem$sendKeysToElement
?webElem$getElementText

?sapply



# 아고다 홈페이지 크롤링
driver <- remoteDriver(port=4445, browserName="chrome")
driver$open()
driver$navigate("https://www.agoda.com/ko-kr/shilla-stay-seocho/hotel/seoul-kr.html?cid=-204")

later_btn <- driver$findElement(using = "xpath", value = '//*[@id="SearchBoxContainer"]/div/div/div[5]/div/div/div[1]/a')
later_btn$clickElement()

test <- NULL
test <- driver$findElement(using = 'css', value = '#customer-reviews-panel > span')
test

driver$executeScript("scrollBy(0, 8400)")
test <- NULL
test <- driver$findElement(using = 'css', value = '#customer-reviews-panel > span')
test



# yes24 홈페이지 크롤링 - 대강 설명만 해줌
# 1. yes24 명견만리 페이지 접근
remDr <- remoteDriver(port=4445, browserName="chrome")
remDr$open()
remDr$navigate("http://www.yes24.com/Product/goods/40936880")

# 2. 리뷰 창 활성화
remDr$executeScript("scrollBy(0, 10000)")
review_btn <- remDr$findElement(using = "css",value = "#yDetailTabNavWrap > div > div > ul > li:nth-child(2) > a")
review_btn$clickElement()

# 3. 페이지 전환
# 4. 마지막 페이지 확인
# 5. 펼쳐보기 > 리뷰 크롤링 * 5회




?driver$executeScript("scrollBy(0,2500)") # 현재 창에서 2500 스크롤 - 상대적
?driver$executeScript("scrollBy(0,2500)") # 맨 위에서 2500만큼까지 스크롤 - 절대적


