# function define
myFunction <- function() {
  print(LETTERS[1])
  print(LETTERS[2])
  today <- weekdays( Sys.Date() )
  if (today=='금요일') {
    return()
  }
  print(LETTERS[3])
  print(LETTERS[4])
  return('END')
}
myFunction()
r <- myFunction()
r

sum(LETTERS)  # error
matrix(1:7, nrow = 3)  # warning


# function define with error/warning message
testError <- function(x) {
  if (x<=0) {
    stop('양의 값만 전달하숑!')
  }
  return( rep('test', x) )
}
testError(5)
x <- testError(5); x
testError(0)  # error
x <- testError(0); x  # error

testWarn <- function(x) {
  if (x<=0) {
    stop('양의 값만 전달하숑!')
  }
  if (x>5) {
    x <- 5
    warning('5보다 크면 안됨! 그래서 5로 처리함!')
  }
  return( rep('test', x) )
}
testWarn(3)
x <- testWarn(3); x
testWarn(0)
x <- testWarn(0); x
testWarn(7)
x <- testWarn(7); x

test1 <- function() {
  cat('난 수행됨\n')
  testError(-1)  # error
  cat('나 수행할까요?/n')
}
test1()


# try
test2 <- function() {
  cat('난 수행됨\n')
  try(testError(-1))  # error
  cat('나 수행할까요?\n')
}
test2()


# tryCatch
testAll <- function(p) {
  tryCatch({
    if (p=='오류테스트') {
      testError(-1)
    } else if(p=='경고테스트') {
      testWarn(6)
    } else {
      cat('정상수행..\n')
      print(testError(2))
      print(testWarn(3))
    }
  }, warning = function(w){
    print(w)
    cat('-_-\n')
  }, error = function(e) {
    print(e)
    cat('ㅠㅠ \n')
  }, finally = {
    cat('오류, 경고 발생 여부를 따라서 반드시 수행되는 부분입니다\n')
  })
  print('함수 종료')
}
testAll('오류테스트')
testAll('경고테스트')
testAll('아무거나')


# any()
f.case1 <- function(x) {
  if (is.na(x)) {
    return('NA가 있슈')
  } else {
    return('NA가 없슈')
  }
}
f.case1(3)
f.case1(NA)
f.case1(1:6)
f.case1(c(NA, 20))
f.case1(c(20, NA, 20))

f.case2 <- function(x) {
  if (any(is.na(x))) {
    return('NA가 있슈')
  } else {
    return('NA가 없슈')
  }
}
f.case2(3)
f.case2(NA)
f.case2(1:6)
f.case2(c(NA, 20))
f.case2(c(20, NA, 20))

f.case3 <- function(x) {
  if (all(is.na(x))) {
    return('모두 NA임')
  } else {
    return('모두 NA인 것은 아님')
  }
}
f.case3(3)
f.case3(NA)
f.case3(1:6)
f.case3(c(NA, 20))
f.case3(c(NA, NA, NA))


# Sys.sleep(초시간) 함수
testSleep <- function(flag) {
  for (data in 1:5) {
    cat(data, '\n')
    if (flag) {
      Sys.sleep(data)
    }
  }
}
testSleep(T)
testSleep(F)


