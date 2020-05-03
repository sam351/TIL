library(httr)
library(rvest)

url <- "http://unico2013.dothome.co.kr/crawling/post.php"
res <- POST(url, encode = "form", body = list(name = "R", age = 27))

nodes <- html_nodes(read_html(res), "h1")
print(html_text(nodes))

