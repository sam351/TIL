
site <- "https://movie.daum.net/moviedb/grade?movieId=125080&type=netizen&page="
moview_review <- data.frame()

for (i in 1:20) {
  url <- paste0(site, i)
  text <- read_html(url)
  
  nodes <- html_nodes(text, "#mArticle > div.detail_movie.detail_rating > div.movie_detail > div.main_detail > ul > li > div > div.raking_grade > em")
  scores <- html_text(nodes)
  
  nodes <- html_nodes(text, "#mArticle > div.detail_movie.detail_rating > div.movie_detail > div.main_detail > ul > li > div > p")
  reviews <- html_text(nodes, trim = T)
  reviews <- gsub("[\r\n]","",reviews)
  
  page <- data.frame(scores, reviews)
  moview_review <- rbind(moview_review, page)
}

write.csv(moview_review, "daummovie2.csv")






