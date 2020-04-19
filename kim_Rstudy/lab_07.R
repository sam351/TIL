# 문제1
exam5 <- function(num1, str1='#') {
  if (num1<0) { }
  else { print(rep(str1, num1)) }
  return(NULL)
}
exam5(3, '*')
exam5(-1, '*')
exam5(3)
exam5(-1)



# 문제2
exam6 <- function(vec1) {
  for (tmp_score in vec1) {
    result6 <- exam6_classifier(tmp_score)
    print(result6)
  }
  return(NULL)
}

exam6_classifier <- function(tmp_score) {
  if (is.na(tmp_score)) {
    tmp_result <- 'NA는 처리불가'
  } else {
    tmp_grade <- paste0(
      switch( sum(tmp_score==c(85:100)),'상' ),
      switch( sum(tmp_score==c(70:84)),'중' ),
      switch( sum(tmp_score==c(0:69)),'하' ) )
    tmp_result <- paste0(tmp_score, ' 점은 ',
                        tmp_grade, '등급입니다.')
  }
  return(tmp_result)
}

test_vec <- c(86, 100, 70, 80, 84, 69, 0, NA)
exam6(test_vec)



# 문제3
countEvenOdd <- function(vec1) {
  if (!is.numeric(vec1)) {
    result <- NULL
  } else {
    result <- countEvenOdd_counter(vec1)
  }
  return(result)
}

countEvenOdd_counter <- function(vec1) {
  cnt_even <- 0
  cnt_odd <- 0
  for (num in vec1) {
    if (num%%2==0) {
      cnt_even <- cnt_even+1
    } else {
      cnt_odd <- cnt_odd+1
    }
  }
  r_list = list( even = cnt_even, 
                 odd = cnt_odd )
  return(r_list)
}

test_vec <- c(0, 12, 13, 11, 14)
test <- countEvenOdd(test_vec); test



# 문제4
vmSum <- function(vec1) {
  if (!is.vector(vec1)) {
    print('벡터만 전달하숑!')
    result <- NULL
  } else if (!is.numeric(vec1)) {
    print('숫자 벡터를 전달하숑!')
    result <- 0
  } else {
    result <- sum(vec1)
  }
  return(result)
}

test_vec1 <- list(1,2,3)
test_vec2 <- c('1','2','3')
test_vec3 <- c(1,2,3)
test <- vmSum(test_vec1); test
test <- vmSum(test_vec2); test
test <- vmSum(test_vec3); test



# 문제5
vmSum2 <- function(vec1) {
  if (!is.vector(vec1)) {
    stop('벡터만 전달하숑!')
  } else if (!is.numeric(vec1)) {
    warning('숫자 벡터를 전달하숑!')
    result <- 0
  } else {
    result <- sum(vec1)
  }
  return(result)
}

test_vec1 <- data.frame(1,2,3)
test_vec2 <- list(1,2,3)
test_vec3 <- c('1','2','3')
test_vec4 <- c(1,2,3)
test <- vmSum2(test_vec1); test
test <- vmSum2(test_vec2); test
test <- vmSum2(test_vec3); test
test <- vmSum2(test_vec4); test


