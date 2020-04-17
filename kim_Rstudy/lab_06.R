# 문제1
exam1 <- function() {
  r_vec <- paste( LETTERS, letters, sep='' )
  return(r_vec)
}
result1 <- exam1(); result1

# 문제2
exam2 <- function(num) {
  r_sum <- 0
  for (i in 1:num) {
    r_sum <- r_sum + i
  }
  return(r_sum)
}
result2 <- exam2( 10 ); result2

# 문제3
exam3 <- function(num1, num2) {
  r_abs_diff <- num1 - num2
  if (r_abs_diff < 0) {
    r_abs_diff <- -(r_abs_diff)
  }
  return(r_abs_diff)
}
result3 <- exam3(5, 20); result3
result3 <- exam3(20, 5); result3

# 문제4
exam4 <- function(num1, string, num2) {
  oper_vec <- c( '+','-','*','%/%','%%' )
  if (!sum( string==oper_vec )) {
    result_val <- '규격의 연산자만 전달하세요'
  } else if ( sum( string==oper_vec[4:5] ) & num1==0 ) {
    result_val <- '오류1'
  } else if ( sum( string==oper_vec[4:5] ) & num2==0 ) {
    result_val <- '오류2'
  } else {
    result_val <- switch(EXPR = string, 
                         '+'=num1+num2,
                         '-'=num1-num2,
                         '*'=num1*num2,
                         '%/%'=num1%/%num2,
                         '%%'=num1%%num2 )
  }
  return(result_val)
}

test_num1 <- 0
test_num2 <- 2
test_num3 <- 3
result4 <- exam4(test_num1, 'test', test_num2); result4  # "규격의 연산자만 전달하세요"
result4 <- exam4(test_num1, '%/%', test_num2); result4  # "오류1"
result4 <- exam4(test_num2, '%%', test_num1); result4  # "오류2"
result4 <- exam4(test_num2, '+', test_num3); result4  # (2+3=) 5
result4 <- exam4(test_num2, '%%', test_num3); result4  # (2%%3=) 2

