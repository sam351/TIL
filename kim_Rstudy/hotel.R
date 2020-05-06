# 아고다 홈페이지 크롤링
rm(list = ls())

# 아고다 홈페이지 접속해서 전체 리뷰 창 띄우기
driver <- remoteDriver(port=4445, browserName="chrome")
driver$open()
driver$navigate("https://www.agoda.com/ko-kr/shilla-stay-seocho/hotel/seoul-kr.html?cid=-204")

later_btn <- driver$findElement(using = "xpath", value = '//*[@id="SearchBoxContainer"]/div/div/div[5]/div/div/div[1]/a')
later_btn$clickElement()

driver$executeScript("scrollBy(0, 8400)")
try( {revies_btn <- driver$findElement("css", "#customer-reviews-panel > button > div > span");
      revies_btn$clickElement() })
Sys.sleep(1)

# 페이지 넘어가며 리뷰 크롤링
result_text <- NULL
page_num <- 1
while (TRUE) {
  tmp_review_nodes <- driver$findElements(using = "css",value = "#reviewSectionComments > div > div.Review-comment-right > div.Review-comment-bubble > div.Review-comment-body > p.Review-comment-bodyText")
  tmp_review_list <- sapply(tmp_review_nodes, function(x) {x$getElementText()} )
  tmp_review_vec <- unlist(tmp_review_list)
  
  if (page_num%%5==0) {
    cat(page_num, "페이지에서 댓글", length(tmp_review_vec), "개를 가져옴\n")
  }
  result_text <- c(result_text, tmp_review_vec)
  
  next_btn <- driver$findElement("css", "#reviewSection > div:nth-child(4) > div > span:nth-child(3) > i")
  tryCatch( {
    next_btn$clickElement()
  }, error = function( e ) {
    cat(page_num, "페이지에서 (마지막으로) 댓글", length(tmp_review_vec), "개를 가져옴\n");
    break;
  } )
  page_num <- page_num + 1
  Sys.sleep(1)
}

cat("총", length(result_text), "개의 댓글 추출\n")
write(result_text, "hotel.txt")

