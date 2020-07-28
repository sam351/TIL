library(dplyr)
library(tm)
library(proxy)
library(qgraph)

# 1. 텍스트 벡터 생성
corp_vec <- '사과 포도 망고
포도 자몽 자두
복숭아 사과 포도
오렌지 바나나 복숭아
포도 바나나 망고
포도 귤 오렌지'
corp_vec <- unlist(strsplit(text, '\n'))


# 2. 텍스트 구조화
cps <- VCorpus(VectorSource(corp_vec))
tdm <- TermDocumentMatrix(cps, 
                          control = 
                            list(wordLengths = c(1, Inf)))
dtm <- DocumentTermMatrix(cps, 
                          control = 
                            list(wordLengths = c(1, Inf)))
inspect(tdm)
inspect(dtm)

w_bag <- as.matrix(tdm)
colnames(w_bag) <- c('듀크', '둘리', '또치', 
                     '도우너', '길동', '희동')


# 3. 정보 추출
# 3-(1) 좋아하는 과일이 가장 유사한 친구들
tmp_com <- t(w_bag) %*% w_bag
dist(tmp_com, method = "Euclidean")
qgraph(tmp_com, labels=rownames(tmp_com), diag=F, 
       layout='spring',  edge.color='blue', 
       vsize=diag(com)*5)
## 결론 : 듀크와 또치, 듀크와 길동의 유사도가 제일 높음


# 3-(2) 학생들에게 가장 많이 선택된 과일을 찾아본다.
freq_df <- rowSums(w_bag) %>% data.frame()
colnames(freq_df) <- 'freq'
freq_df %>% arrange(desc(freq))
## 결론 : 포도가 5개로 가장 많이 선택됨
## 문제 : 데이터프레임 arrange하면 rownames가 없어짐

# 3-(3) 학생들에게 가장 적게 선택된 과일을 찾아본다.
rowSums(w_bag) %>% data.frame()
## 결론 : 귤, 자두, 자몽이 1개로 가장 적게 선택됨
