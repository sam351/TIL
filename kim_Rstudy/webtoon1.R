# 셀레늄 실습 - 네이버 웹툰 베스트댓글&전체댓글 크롤링
driver <- remoteDriver(port=4445, browserName="chrome")
driver$open()
driver$navigate("https://comic.naver.com/comment/comment.nhn?titleId=570503&no=135")

# 베스트 댓글 벡터화
Sys.sleep(2)
bestReview_nodes <- driver$findElements(using = "css", value = "ul.u_cbox_list span.u_cbox_contents")
cat("베스트 댓글", length(bestReview_nodes), "개를 가져옴\n")
bestReview_list <- sapply(X = bestReview_nodes , FUN = function(x) {x$getElementText()} )
bestReview_vec <- unlist(bestReview_list)
bestReview_vec <- gsub("[[:cntrl:]]", "", bestReview_vec)
cat("정상 확인 - 마지막 베스트 댓글 : ", bestReview_vec[15], "\n")
print("전체 댓글 크롤링 시작...")
Sys.sleep(2)


# 전체 댓글 클릭
btn_node1 <- driver$findElement(using = "css", value = "div.u_cbox_sort > div.u_cbox_sort_option > div > ul > li:nth-child(2) > a > span.u_cbox_sort_label")
# btn_node1$getElementTagName()  - span 태그인지 확인
btn_node1$clickElement()
Sys.sleep(2)

# 전체 댓글 벡터화
totalReview_vec <- as.character()
for (page_num in 3:12) {
  if (page_num != 3) {
    tmp_btn <- driver$findElement(using = "css", value = paste0("div.u_cbox_page_wrap > a:nth-child(", page_num, ")"))
    tmp_btn$clickElement()
    Sys.sleep(1)
  }
  
  tmp_review_nodes <- driver$findElements(using = "css", value = "ul.u_cbox_list span.u_cbox_contents")
  cat(page_num-2, "페이지에서 댓글", length(tmp_review_nodes), "개 가져옴\n")
  
  tmp_review_list <- sapply(X = tmp_review_nodes , FUN = function(x) {x$getElementText()} )
  tmp_review_vec <- unlist(tmp_review_list)
  tmp_review_vec <- gsub("[[:cntrl:]]", "", tmp_review_vec)
  
  totalReview_vec <- c(totalReview_vec, tmp_review_vec)
}

# 벡터들 결합해 텍스트로 저장
result_text <- c(bestReview_vec, totalReview_vec)
cat("네이버 웹툰 댓글 총", length(result_text), "개를 가져옴\n")

write(result_text, "webtoon1.txt")
