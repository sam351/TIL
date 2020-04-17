# loop
for (data in month.name) print(data)

sum <- 0
for (i in 5:15) {
  if (i%%10==0) {
    break
  }
  sum <- sum + i
  print(paste(i, ':', sum))
}

sum <- 0
for (i in 5:15) {
  if (i%%10==0) {
    next
  }
  sum <- sum + i
  print(paste(i, ':', sum))
}

sumNumber <- 0
while (sumNumber <= 20) {
  i <- sample(1:5, 1)
  sumNumber <- sumNumber + i
  cat(sumNumber, '\n')
}

sumNumber <- 0
repeat{
  i <- sample(1:5, 1)
  sumNumber <- sumNumber + i
  cat(sumNumber, '\n')
  if (sumNumber>20) break }


# function define
f1 <- function() print("TEST")
f1()

f2 <- function( num ) { print("TEST") ; print(num) }
f2(100)

f3 <- function(p='R') { print(p) }
f3()
f3('python')
f3('java')

f4 <- function(p1='lol', p2) {
  for (i in 1:p2) {
    print(p1)
  }
}
f4('abc',3)
f4( 4 )  # error
f4( p2=4 )

f5 <- function( ... ){
  print('Test')
  data <- c(...)
  print(length(data))
}
f5(10, 20, 30)
f5('ab', T, 1, 2)

func1 <- function() {
  xx <- 10
  yy <- 20
  return(xx*yy)
}
func1()
xx  # error

func2 <- function(x, y) {
  xx <- x
  yy <- y
  return(sum(xx, yy))
}
func2()  # error
func2(5,6)

func3 <- function(x, y) {
  x3 <- x+1
  y3 <- y+1
  x4 <- func2(x3, y3)
  return(x4)
}
func3(9, 19)

testParamType <- function(x) {
  if ( is.vector (x) ) { print('벡터를 전달했군요!') }
  if ( is.matrix (x) ) { print('행렬을 전달했군요!') }
  if ( is.array (x) ) { print('배열을 전달했군요!') }
  if ( is.data.frame (x) ) { print('데이터프레임을 전달했군요!') }
  if ( is.list (x) ) { print('리스트를 전달했군요!') }
  if ( is.function (x) ) { print('함수를 전달했군요!') }
}
rm(sum)
testParamType(100)
testParamType(LETTERS)
testParamType(data.frame())  # 데이터프레임 → 데이터프레임, 리스트
testParamType(matrix())  # 행렬 → 행렬, 배열
testParamType(list())  # 리스트 → 벡터, 리스트
testParamType(array())
testParamType(sum)


f7 <- function(...) {
  data <- c(...)
  sum <- 0;
  for(item in data) {
    if(is.numeric(item))
      sum <- sum + item
    else
      print(item)
  }
  return(sum)
}
f7(10,20,30)
f7(10,20,'test', 30,40)

f8 <- function(...) {
  data <- list(...)
  sum <- 0;
  for(item in data) {
    if(is.numeric(item))
      sum <- sum + item
    else
      print(item)
  }
  return(sum)
}
f8(10,20,30)
f8(10,20,'test', 30,40)
