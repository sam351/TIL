setwd('c:/Rstudy')

# crawling with rvest
library(rvest)

url <- "http://unico2013.dothome.co.kr/crawling/tagstyle.html"
text <- read_html(url)
text

nodes <- html_nodes(text, "div")
nodes
title <- html_text(nodes)
title

node1 <- html_nodes(text, "div:nth-of-type(1)")
node1
html_text(node1)
html_attr(node1, "style")

node2 <- html_nodes(text, "div:nth-of-type(2)")
node2
html_text(node2)
html_attr(node2, "style")


# Naver movie crawling
url <- "https://movie.naver.com/movie/point/af/list.nhn?page=1"
text <- read_html(url)
nodes_moive <- html_nodes(text, "#old_content > table > tbody > tr:nth-child(4) > td.title > a.movie")
html_text(nodes_moive)

nodes_moives <- html_nodes(text, "#old_content > table > tbody > tr > td.title > a.movie")
html_text(nodes_moives)
html_attr(nodes_moives, 'href')


# Naver movie crawling into df
url <- "https://movie.naver.com/movie/point/af/list.nhn"
text <- read_html(url, encoding = "CP949")
nodes <- html_nodes(text, ".movie")  # 영화제목 스크래핑
title <- html_text(nodes)

nodes <- html_nodes(text, ".title")  # 영화리뷰 스크래핑
review <- html_text(nodes, trim = T)

review <- gsub("\t", "", review)
review <- gsub("\r\n", "", review)
review <- gsub("\n", "", review)
review <- gsub("신고", "", review)

page <- data.frame(title, review)
write.csv(page, "movie_reviews.csv")


# Naver movie crawling * 100 into df
site <- "https://movie.naver.com/movie/point/af/list.nhn?&page="
moview_review <- NULL
for (i in 1:100) {
  url <- paste0(site, i)
  text <- read_html(url, encoding = "CP949")
  nodes <- html_nodes(text, ".movie")  # 영화제목 스크래핑
  title <- html_text(nodes)
  
  nodes <- html_nodes(text, ".title")  # 영화리뷰 스크래핑
  review <- html_text(nodes, trim = T)
  
  review <- gsub("\t", "", review)
  review <- gsub("[\r\n]", "", review)
  review <- gsub("신고", "", review)
  
  page <- data.frame(title, review)
  moview_review <- rbind(moview_review, page)
}
View(moview_review)
write.csv(moview_review, "movie_reviews2.csv")

