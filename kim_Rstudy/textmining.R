
raw_text <- readLines("data/memo.txt", encoding = "UTF-8")

# 벡터에서 빈 문자열 원소 제거
for (idx in length(raw_text):1) {
  if (raw_text[idx]=="") {
    raw_text <- raw_text[-idx]
  }
}

# 원소별 전처리
raw_text[1] <- gsub("[&$!#@%]","", raw_text[1])
raw_text[2] <- gsub("e","E", raw_text[2])
raw_text[3] <- gsub("[12]","", raw_text[3])
raw_text[4] <- gsub("[A-Za-z]","", raw_text[4])
raw_text[4] <- gsub("  "," ", raw_text[4])
raw_text[5] <- gsub("[0-9!<>]","", raw_text[5])
raw_text[6] <- gsub(" ","", raw_text[6])
raw_text[7] <- tolower(raw_text[7])

write( raw_text, "memo_new.txt" )
