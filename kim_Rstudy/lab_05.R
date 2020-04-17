# 문제1
grade <- sample(1:6, 1)
tmp_flag <- switch (EXPR = as.character(grade),
  '1'=, '2'=, '3'='저학년',
  '고학년' )
cat( grade, ' 학년은 ', tmp_flag, '입니다\n', sep='' )

# 문제2
choice <- sample(1:5, 1)
tmp_result <- switch (EXPR = choice,
  300+50, 300-50, 300*50, 300/50, 300%%50 )
cat('결과값 :', tmp_result, '\n')

# 문제3
count <- sample(3:10, 1)
deco <- sample(1:3, 1)
for (num in 1:count) {
  switch (EXPR = deco,
          cat( '*' ),
          cat( '$' ), 
          cat( '#' ) )
}

# 문제4
score <- sample(0:100, 1)
level <- paste(
  switch (EXPR = sum(score==c(90:100)), 'A'),
  switch (EXPR = sum(score==c(80:89)), 'B'),
  switch (EXPR = sum(score==c(70:79)), 'C'),
  switch (EXPR = sum(score==c(60:69)), 'D'),
  switch (EXPR = sum(score==c(0:59)), 'F'),
  sep=''
)
cat(score, '점은', level, '등급입니다.\n')

# 문제5
alpha <- paste(LETTERS, letters, sep=''); alpha
