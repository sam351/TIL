# ref = "http://www.kmooc.kr/courses/course-v1:POSTECHk+CSED490k+2019_T1/course/"
# setwd("")
rm(list = ls())

library(sqldf)

# Selection operation (extracting records)
Employee = data.frame(SSN = c(1234545, 5423341, 4352342),
                      Name = c('John','Smith','Fred'),
                      Salary = c(20000, 60000, 50000))
sqldf('SELECT * FROM Employee')
sqldf('SELECT * FROM Employee
      WHERE Salary > 40000')


# Union operation
R1 = data.frame(A = c('a1','a2'), B=c('b1','b1'))
R2 = data.frame(A = c('a1','a3'), B=c('b1','b4'))
sqldf('SELECT * FROM R1')
sqldf('SELECT * FROM R2')
sqldf('SELECT * FROM R1
      UNION
      SELECT * FROM R2')  # set semantic - distinct
sqldf('SELECT * FROM R1
      UNION ALL
      SELECT * FROM R2')  # bag semantic - duplication


# Difference operation
sqldf('SELECT * FROM R1
      EXCEPT
      SELECT * FROM R2')


# Projection operation (extracting columns)
Employee = data.frame(SSN = c(1234545,5423341,4352342),
                      NAME = c('John','John','John'),
                      Salary = c(20000, 60000, 20000))
sqldf('SELECT * FROM Employee')
sqldf('SELECT NAME, Salary FROM Employee')
sqldf('SELECT DISTINCT NAME, Salary
      FROM Employee')  # duplication elimination


# Cross Product operation (Concatenate all pairs of tuples of each tables)
Employee = data.frame(Name = c('John','Tony'),
                      SSN = c(999999,777777))
Dependent = data.frame(EmpSSN = c(999999,777777),
                       DepName = c('sales','Develop'))
sqldf('SELECT * FROM Employee')
sqldf('SELECT * FROM Dependent')
sqldf('SELECT * FROM Employee, Dependent')


# Intersection operation - JOIN
sqldf('SELECT * FROM R1')
sqldf('SELECT * FROM R2')
## equi-JOIN
sqldf('SELECT * FROM R1, R2
      WHERE R1.A = R2.A')
sqldf('SELECT * FROM R1
      JOIN R2 ON R1.A=R2.A')
## theta-JOIN - Not run
# sqldf('SELECT h.name FROM Hospitals h
#       JOIN Schools s
#       ON distance(h.location, s.location) < 5')
# sqldf('SELECT h.name FROM Hospitals h, Schools s
#       WHERE distance(h.location, s.location) < 5')
# sqldf('
#       SELECT * FROM Clicks c, PageLoads p
#       WHERE abs(c.click_time - p.load_time) < 5
#       ')


# Outer JOIN
Patient = data.frame(age = c(54,20,33),
                     zip = c(98125,98120,98120),
                     disease = c('heart','flu','lung'))
Job = data.frame(age = c(54,20),
                 zip = c(98125,98120),
                 job = c('lawyer','cashier'))
sqldf('SELECT * FROM Patient LIMIT 5')
sqldf('SELECT * FROM Job LIMIT 5')
sqldf('SELECT p.age, p.zip, p.disease, j.job
      FROM Patient p 
      LEFT JOIN Job j ON p.age=j.age AND p.zip=j.zip')


# CREATE table, INSERT INTO table, DELETE FROM
sqldf(c('create table BANK(Account int, Branch text, Country text, Balance int);',
        'INSERT INTO BANK VALUES (100090, "Seoul", "Korea", 10000);',
        'INSERT INTO BANK VALUES (100092, "Seoul", "Korea", 5000);',
        'SELECT * FROM BANK'))

sqldf(c('create table BANK(Account int, Branch text, Country text, Balance int);',
        'INSERT INTO BANK VALUES (100090, "Seoul", "Korea", 10000);',
        'INSERT INTO BANK VALUES (100092, "Seoul", "Korea", 5000);',
        
        'DELETE FROM BANK
        WHERE Account=100090 AND Branch="Seoul"',
        'SELECT * FROM BANK'))
