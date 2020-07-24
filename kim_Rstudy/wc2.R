library("htmlwidgets")
library(dplyr)
library(wordcloud2)

# 1. 데이터 불러오기
raw_corpus <- readLines('data/yes24.txt')


# 2. 전처리 - 명사만 추출해 vector로 저장
noun_list <- extractNoun(raw_corpus)
noun_vec <- unlist(noun_list)
length(noun_vec)  # 16695개
noun_vec <- noun_vec[nchar(noun_vec)>=2]
length(noun_vec)  # 11525개
head(noun_vec)


# 3. 전처리 - 빈도표 생성해 df로 저장
noun_df <- data.frame(table(noun_vec))
nrow(noun_df)  # 2791
noun_df <- noun_df %>% filter(Freq>=3) 
nrow(noun_df)  # 795


# 4. 워드클라우드 그리기
result <- 
  wordcloud2(noun_df,
             fontFamily = '휴먼옛체',
             rotateRatio = 0.5,
             size=1)
result

saveWidget(result, "wc2.html",
           title="WORDCLOUD2 실습",
           selfcontained = F)
