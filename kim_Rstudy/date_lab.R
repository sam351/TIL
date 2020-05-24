#(1) 내가 태어난 요일 출력하기
format( as.Date('1992-10-21'), '%A' )


#(2) 내가 태어난지 며칠이 되었는지 알아보기
Sys.Date() - as.Date('1992-10-21')


#(3) 올해의 크리스마스 요일 2가지방법(요일명,숫자)
format(as.Date('2019-12-25'), '%A')
unclass( as.POSIXlt('2019-12-25') )$wday
# other way
# weekdays(as.Date('2019-12-25'))
# as.POSIXlt('2019-12-25')$wday


#(4) 2020년 1월 1일 어떤 요일
format( as.Date('2020-1-1'), '%A' )


#(5) 오늘은 xxxx년x월xx일x요일입니다 형식으로 출력
tmp_date <- unlist( as.POSIXlt( Sys.Date() ) )  # class = num
tmp_wday <- format( Sys.Date() , '%a')
print(paste0( '오늘은 ', 
     tmp_date['year']+1900, '년', 
     tmp_date['mon']+1, '월',
     tmp_date['mday'], '일',
     tmp_wday,'요일입니다' ))
# other way
# format(Sys.Date(), '오늘은 %Y년%m월%d일%a요일입니다')


# (6) emp 데이터셋에서 직원들의 입사년도만 출력
emp <- read.csv('data/emp.csv', stringsAsFactors = F)
format( as.Date(emp$hiredate), '%Y' )
