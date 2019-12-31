# ref = "https://opentutorials.org/course/3161/19539"
# ref = "https://opentutorials.org/course/3161/19540"
# ref = "https://opentutorials.org/course/3161/19541"
# ref = "https://opentutorials.org/course/3161/19542"
# setwd("")
rm(list = ls())

library(sqldf)

topic = data.frame(id = 1:5,
                   title = c('MySQL','ORACLE','SQL Server','PostgreSQL','MongoDB'),
                   description = c('d1','d2','d3','d4','d5'),
                   created = c('2018-01-10','2018-01-15','2018-01-18','2018-01-20','2018-01-30'),
                   author = c('egoing','egoing','duru','taeho','egoing'),
                   profile = c('developer','developer','DBA','developer, DS','developer'))
sqldf('SELECT * FROM topic')


# INSERT INTO table (columns) VALUES (values)
sqldf(c('INSERT INTO topic (id, title, author, description)
      VALUES (6, "MYSQL2","egoing","d6");',
        
        'SELECT * FROM topic;'))


# SELECT
sqldf('SELECT id, title, author, created FROM topic')

sqldf('SELECT id, title, created, author FROM topic
      WHERE author="egoing"')

sqldf('SELECT id, title, created, author FROM topic
      WHERE author="egoing"
      ORDER BY id DESC')

sqldf('SELECT id, title, created, author FROM topic
      WHERE author="egoing"
      ORDER BY id DESC
      LIMIT 2')


# UPDATE table SET column=value [WHERE condition] - MUST include WHERE!
sqldf(c('UPDATE topic
        SET description = "desc_"||id',
        
        'SELECT * FROM topic LIMIT 10'))

sqldf(c('UPDATE topic
      SET title = "Oracle"
      WHERE title = "ORACLE"',
        
      'SELECT * FROM topic LIMIT 10'))


# DELETE FROM table [WHERE condition] - MUST include WHERE!
sqldf(c('DELETE FROM topic
        WHERE profile="DBA";',
        
        'SELECT * FROM topic;'))
