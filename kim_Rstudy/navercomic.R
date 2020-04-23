site <- "https://comic.naver.com/genre/bestChallenge.nhn?&page="
page_num <- 0
pre_summary_first <- ""
result_df <- data.frame()

while (TRUE) {
  page_num <- page_num + 1
  url <- paste0(site, page_num)
  text <- read_html(url)
  
  # 첫 번째 summary를 비교해서 마지막 페이지인지 확인하기
  summary_first <- html_text(html_node(text, "div.summary"), trim = T)
  if (summary_first == pre_summary_first) {
    break
  }
  pre_summary_first <- summary_first  # 다음 번 비교를 위해 summary 복사
  
  # 각 변수 생성
  nodes <- html_nodes(text, "div.challengeInfo > h6 > a")
  comicName <- html_text(nodes, trim = T)
  nodes <- html_nodes(text, "div.summary")
  comicSummary <- html_text(nodes)
  nodes <- html_nodes(text, "div.rating_type > strong")
  comicGrade <- html_text(nodes)
  
  tmp_df <- data.frame(comicName, comicSummary, comicGrade)
  result_df <- rbind(result_df, tmp_df)
  
  # 비교를 위해 텍스트 카피
  pre_text <- text
}

write.csv(result_df, "navercomic.csv")
