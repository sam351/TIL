library(rvest)
library(httr)
library(RSelenium)

remDr <- remoteDriver(port=4445, browserName="chrome")

# 1. 스타벅스 홈페이지 > 서울 전체 매장 불러오기
remDr$open()
url_main <- "https://www.istarbucks.co.kr/store/store_map.do?disp=locale"
remDr$navigate(url_main)
Sys.sleep(2)

tmp_btn <- remDr$findElement('xpath', '//*[@id="container"]/div/form/fieldset/div/section/article[1]/article/header[2]/h3/a')
tmp_btn$clickElement()
Sys.sleep(2)

tmp_btn <- remDr$findElement('xpath', '//*[@id="container"]/div/form/fieldset/div/section/article[1]/article/article[2]/div[1]/div[2]/ul/li[1]/a')
tmp_btn$clickElement()
Sys.sleep(2)

tmp_btn <- remDr$findElement('xpath', '//*[@id="mCSB_2_container"]/ul/li[1]/a')
tmp_btn$clickElement()
Sys.sleep(2)


# 2. 서울 전체 매장 정보 수집하기
# 매장명(shopname), 위도(lat), 경도(lng), 주소(addr), 전화번호(telephone)
# 3개 수집할 때마다 스크롤
total_num <- length(remDr$findElements('xpath', '//*[@id="mCSB_3_container"]/ul/li[@class="quickResultLstCon"]'))

shopname <- NULL
lat <- NULL
lng <- NULL
addr <- NULL
telephone <- NULL

for (cnt in 1:total_num) {
  tmp_css <- paste0( '#mCSB_3_container > ul > li:nth-child(', cnt, ')' )
  tmp_elem <- remDr$findElement('css', tmp_css)
  
  # Element Attribute > lat, lng
  tmp_lat <- tmp_elem$getElementAttribute(attrName = 'data-lat')
  tmp_lat <- as.character(tmp_lat)
  lat <- c(lat, tmp_lat)
  
  tmp_lng <- tmp_elem$getElementAttribute(attrName = 'data-long')
  tmp_lng <- as.character(tmp_lng)
  lng<- c(lng, tmp_lng)
  
  # Element Text > name, addr, tel
  tmp_chr <- tmp_elem$getElementText()
  tmp_chr <- as.character(tmp_chr)
  
  tmp_name <- strsplit(tmp_chr, '\n')[[1]][1]
  shopname <- c(shopname, tmp_name)
  
  tmp_addr <- strsplit(tmp_chr, '\n')[[1]][2]
  addr <- c(addr, tmp_addr)
  
  tmp_tel <- strsplit(tmp_chr, '\n')[[1]][3]
  telephone <- c(telephone, tmp_tel)
  
  # scroll every third time (1-2-3-scroll)
  if (cnt%%3==0) {
    tmp_css <- paste0( '#mCSB_3_container > ul > li:nth-child(', cnt+1, ')' )
    remDr$executeScript(script = "var dom = document.querySelector( arguments[0] );
                                  dom.scrollIntoView();",
                        args = list(tmp_css))
  }
  
  # checkpoints
  if (cnt%%100==0) {
    cat(cnt, '번째 매장정보 추출됨.\n')
  }
}



# 3. 수집된 서울 전체 매장 정보 df와 csv에 저장하기
res_df <- data.frame(shopname, lat, lng, addr, telephone)

write.csv(res_df, "starbucks_191104.csv")

