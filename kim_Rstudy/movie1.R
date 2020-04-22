
url <- "https://movie.daum.net/moviedb/grade?movieId=125080&type=netizen"
text <- read_html(url)

nodes <- html_nodes(text, "#mArticle > div.detail_movie.detail_rating > div.movie_detail > div.main_detail > ul > li > div > div.raking_grade > em")
scores <- html_text(nodes)

nodes <- html_nodes(text, "#mArticle > div.detail_movie.detail_rating > div.movie_detail > div.main_detail > ul > li > div > p")
reviews <- html_text(nodes, trim = T)
reviews <- gsub("[\r\n]","",reviews)

page <- data.frame(scores, reviews)
write.csv(page, "daummovie1.csv")

