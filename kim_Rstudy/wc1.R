library(dplyr)
library(wordcloud)
library(KoNLP)
useSystemDic()

# 1. 사전 수정
add_words <- c("공구", "롱기")
buildDictionary(user_dic = data.frame(add_words, pos="ncn"),
                replace_usr_dic=T)


# 2. 텍스트 불러오기
raw_corpus <- readLines('data/공구.txt', encoding = 'UTF-8')
str(raw_corpus)


# 3. 텍스트 전처리 - 명사 추출, 문제 일부 제거, 빈 문자열 제거
noun_list <- extractNoun(raw_corpus)
noun_vec <- unlist(noun_list)
noun_vec <- gsub(pattern = '[0-9[:cntrl:][:punct:]]', replacement = '', x = noun_vec)
noun_vec <- noun_vec[nchar(noun_vec)>1]
table(noun_vec)
# noun_vec[noun_vec=='롱기']


# 4. 키워드-빈도 데이터프레임 생성 및 추가 전처리
noun_df <- data.frame(table(noun_vec))
colnames(noun_df) <- c('keyword', 'freq')
noun_df <- noun_df %>% filter(freq<10 & freq>1)


# 5. 워드클라우드 그리기
windowsFonts(lett = windowsFont("휴먼옛체")) # 한글 깨짐 방지

tmp_pal <- RColorBrewer::brewer.pal(6, name = 'Set1')
wordcloud(noun_df$keyword, noun_df$freq,
          rot.per = 0.1, scale = c(4, 1), 
          family = "lett", colors = tmp_pal)


# 6. png 파일 저장
png('wc.png')

wordcloud(noun_df$keyword, noun_df$freq,
          rot.per = 0.1, scale = c(4, 1), 
          family = "lett", colors = tmp_pal)

dev.off()

