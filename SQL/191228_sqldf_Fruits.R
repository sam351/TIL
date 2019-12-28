# ref = "https://blog.naver.com/1stwook/220669097633"
# setwd("")
rm(list = ls())

library(sqldf)
# install.packages("googleVis")
library(googleVis)


# loading data
data("Fruits")
str(Fruits)
sqldf('select * from Fruits')
sqldf('SELECT * FROM Fruits')

# WHERE
sqldf('
      SELECT * FROM Fruits
      WHERE Fruit="Apples"
      ')

# limit
sqldf('
      SELECT * FROM Fruits
      limit 5
      ')

# ORDER BY (DESC)
sqldf('
      SELECT * FROM Fruits
      ORDER BY Year DESC
      ')

# GROUP
sqldf('SELECT SUM(Sales) FROM Fruits')
sqldf('SELECT max(Sales) FROM Fruits')
sqldf('SELECT min(Sales) FROM Fruits')
sqldf('SELECT AVG(Sales) FROM Fruits')
sqldf('
      SELECT Fruit, AVG(Sales) FROM Fruits
      GROUP BY Fruit
      ')
sqldf('
      SELECT Fruit, SUM(Sales) FROM Fruits
      GROUP BY Fruit
      ')
sqldf('SELECT COUNT(*) FROM Fruits')

# Sub Query
## Return One line from Sub Query
sqldf('SELECT Sales FROM Fruits
      WHERE Expenses = 78')
sqldf('
      SELECT * FROM Fruits
      WHERE Sales > (SELECT Sales FROM Fruits
                      WHERE Expenses = 78)
      ')

## Return Some lines from Sub Query
sqldf('
      SELECT Sales FROM Fruits
      WHERE Sales > 95
      ')
sqldf('
      SELECT * FROM Fruits
      WHERE Sales IN (SELECT Sales FROM Fruits
                      WHERE Sales > 95)
      ')

## Return Some lines from Sub Query
var1 = matrix(c('가','라','사')); var1
var2 = data.frame(var1); var2
data = data.frame(CA = c('가','나','다','라',
                         '마','바','사'),
                  LV = c(3,7,11,31,49,78,43),
                  ID = c(3233, 3789, 4939,2336,
                         4555, 7888, 9999)); data
sqldf('SELECT * FROM var2')
sqldf('SELECT ID FROM data
      WHERE CA IN var2')

# JOIN
## basic INNER JOIN
student = data.frame(STUDNO = c(100,200,300,400),
                     NAME = c('Sandra Bullock','Jodie Foster','Meg Ryan','Demi Moore'),
                     PROFNO = c(1000, 2000, 3000, 5000))
professor = data.frame(PROFNO = c(1000, 2000, 3000, 4000),
                       NAME = c('Sandra Bullock','Jodie Foster','Meg Ryan','Demi Moore'))
student
professor
sqldf()  # Debugging - Error: Table student exists in database, and both overwrite and append are FALSE
sqldf('
      SELECT s.NAME Student_Name, p.NAME Prof_Name
      FROM student s, professor p
      WHERE s.PROFNO = p.PROFNO
      ')
sqldf('
      SELECT s.NAME Student_Name, p.NAME Prof_Name
      FROM student s
      JOIN professor p ON s.PROFNO = p.PROFNO
      ')

## OUTER JOIN
sqldf('
      SELECT s.NAME Std_Name, p.NAME Prof_Name
      FROM student s
      LEFT JOIN professor p USING (PROFNO)
      ')
sqldf('
      SELECT p.NAME Prof_Name, s.NAME Std_Name
      FROM professor p
      LEFT JOIN student s USING (PROFNO)
      ')
sqldf('
      SELECT s.NAME Std_Name, p.Name Prof_Name
      FROM student s
      RIGHT JOIN professor p USING (PROFNO)
      ')  # Not Run : not currently supported

## SELF JOIN
emp = data.frame(empno = c(10,20,30,40,50),
                 ename = c('JAMES','MILLER','FORD',
                           'STEVE','ALLEN'),
                 pempno = c(NA, 10, 20, 20, 30))
sqldf('SELECT * FROM emp')
sqldf('
      SELECT a.ename "name", b.ename "p_name"
      FROM emp a, emp b
      WHERE a.pempno = b.empno
      ')
sqldf('
      SELECT a.ename "name", b.ename "p_name"
      FROM emp a
      JOIN emp b ON a.pempno = b.empno
      ')

# UPDATE
sqldf('SELECT * FROM Fruits')
sqldf(c('
        UPDATE Fruits SET Profit=50
        WHERE Fruit="Apples" AND Year=2008
        ', 'SELECT * FROM Fruits'))
sqldf(c('
        UPDATE Fruits SET Profit=50
        WHERE Fruit="Apples" AND Year=2008
        ', 'SELECT * FROM Fruits'))

# DELETE
sqldf(c('DELETE FROM Fruits
        WHERE Fruit="Apples" AND Year=2008',
        'SELECT * FROM Fruits'))
