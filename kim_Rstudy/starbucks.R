
# 스타벅스 홈페이지 이동 > 서울 전체 매장 활성화
remDr <- remoteDriver(port=4445, browserName="chrome")
remDr$open()
url1 <- "https://www.istarbucks.co.kr/store/store_map.do?disp=locale"
remDr$navigate(url1)
Sys.sleep(2)

tmp_btn <- remDr$findElement(using = "xpath",value = '//*[@id="container"]/div/form/fieldset/div/section/article[1]/article/article[2]/div[1]/div[2]/ul/li[1]/a')
tmp_btn$clickElement()
Sys.sleep(2)

tmp_btn <- remDr$findElement(using = "xpath",value = '//*[@id="mCSB_2_container"]/ul/li[1]/a')
tmp_btn$clickElement()
Sys.sleep(2)


# 전체 매장 개수 확인
stores <- remDr$findElements(using = 'xpath', value = '//*[@id="mCSB_3_container"]/ul/li/strong')


# 매장명 수집
result_vec <- as.character()
for(idx in 1:length(stores)) {
  # 매장명 수집
  tmp_store_node <- remDr$findElement(using = "xpath", value = paste0('//*[@id="mCSB_3_container"]/ul/li[', idx, ']/strong'))
  tmp_store_name <- tmp_store_node$getElementText()
  result_vec <- c(result_vec, as.character(tmp_store_name))
  
  # 스크롤 다운
  if ( idx%%3==0 ) {
    remDr$executeScript(
      script = "var su=arguments[0];
      var dom=document.querySelectorAll(
      '#mCSB_3_container > ul > li')[su];
      dom.scrollIntoView();",
      args = list(idx) )
  }
  
  # 중간점검
  if ( idx%%100==0 ) {
    cat(idx, "번째 상점명 수집함\n")
  }
}

tail(result_vec)

write(result_vec, "starbucks.txt")

