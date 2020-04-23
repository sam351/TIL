
url <- "http://media.daum.net/ranking/popular/"
text <- read_html(url)

nodes_title <- html_nodes(text, "ul.list_news2 > li > div.cont_thumb > strong > a")
nodes_name <- html_nodes(text, "ul.list_news2 > li > div.cont_thumb > strong > span")

newstitle <- html_text(nodes_title)
newspapername <- html_text(nodes_name)

df_news <- data.frame(newstitle, newspapername)

write.csv(df_news, "daumnews.csv")
