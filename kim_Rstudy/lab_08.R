# 문제1
mySum <- function(vec1) {
  if( is.null(vec1) ) {
    result <- NULL
  } else if ( !is.vector(vec1) | is.list(vec1) ) {
    stop('벡터만 처리 가능!!')
  } else if( any(is.na(vec1)) ) {
    warning('NA를 최저값으로 변경하여 처리함!!')
    vec1 <- mySum_fillna( vec1 )
    result <- mySum_sumlist( vec1 )
  } else {
    result <- mySum_sumlist( vec1 )
  }
  return(result)
}

mySum_fillna <- function(vec1) {
  tmp_vec <- vector()
  for (num in vec1) {
    if (!is.na(num)) {
      tmp_vec <- c(tmp_vec, num)
    }
  }
  
  for (idx in 1:length(vec1)) {
    if (is.na(vec1[idx])) {
      vec1[idx] <- min(tmp_vec)
    }
  }
  return(vec1)
}

mySum_sumlist <- function(vec1) {
  r_list <- list(oddSum = 0, evenSum = 0)
  for (idx in 1:length(vec1)) {
    if (idx%%2) {
      r_list$oddSum <- r_list$oddSum + vec1[idx]
    } else {
      r_list$evenSum <- r_list$evenSum + vec1[idx]
    }
  }
  return(r_list)
}

mySum(c(1,2,3))
mySum(list(1,2,3))
mySum(c(1,2,NA,4,5))
mySum(NULL)



# 문제2
myExpr <- function(f1) {
  if (!is.function(f1)) {
    stop('수행 안할꺼임!!')
  } 
  tmp_sample <- sample(1:45, 6)
  result <- f1(tmp_sample)
  return(result)
}

myExpr(sum)
myExpr(min)
myExpr(c(1))
myExpr('min')



# 문제3
createVector <- function(...) {
  result <- c(...)
  if (is.null(result)) {
    result <- NULL
  } else if (any(is.na(result))) {
    result <- NA
  }
  return(result)
}

createVector()
createVector(NULL)
createVector(NULL, NULL)
createVector(1, NA, 1)
createVector(1,2,3)
createVector(1,'2',3)
createVector(1,T,'2')



# 문제4
vec1 <- scan('./data/iotest1.txt')
r1 <- sort(vec1)
r2 <- sort(vec1, decreasing = T)
r3 <- sum(vec1)
r4 <- mean(vec1)
cat('오름차순 :', r1, '\n'); cat('내림차순 :', r2, '\n'); cat('합 :', r3, '\n'); cat('평균 :', r4, '\n')



# 문제5
vec2 <- scan(what = '', './data/iotest2.txt')
word_bag <- vector()
for (tmp_str in vec2) {
  word_bag[tmp_str] <- 0
}
for (tmp_str in vec2) {
  word_bag[tmp_str] <- word_bag[tmp_str]+1
}
word_bag <- sort(word_bag, decreasing = T)
mode_str <- names(word_bag[1])
cat('가장 많이 등장한 단어는', mode_str, '입니다.\n')
