# ref = "http://www.kmooc.kr/courses/course-v1:POSTECHk+CSED490k+2019_T1/course/"
# setwd("")
rm(list = ls())

library(sqldf)

Documents = read.csv('191230_Documents.csv', header = F,
                     col.names = c('Docid', 
                                   'Term', 'count'))
sqldf('SELECT * FROM Documents LIMIT 5')
sqldf('SELECT count(Docid) no_row FROM Documents')

# SQL exercise 1
sqldf('SELECT Term FROM Documents WHERE Docid = 2')
sqldf('SELECT Term FROM Documents WHERE Docid = 3')
sqldf('SELECT Term FROM Documents WHERE Docid = 2
      UNION
      SELECT Term FROM Documents WHERE Docid = 3')
sqldf('SELECT Term FROM Documents WHERE Docid = 2
      UNION ALL
      SELECT Term FROM Documents WHERE Docid = 3')  # 2번 문서와 3번 문서에 겹치는 단어가 없어서 위 두 쿼리의 결과가 같은 것

sqldf('SELECT Term FROM Documents WHERE Docid=2
      UNION
      SELECT Term FROM Documents WHERE count=3')  # 6개
sqldf('SELECT Term FROM Documents WHERE Docid=2
      UNION ALL
      SELECT Term FROM Documents WHERE count=3')  # 10개
sqldf('SELECT Term FROM Documents
      WHERE Docid=2 OR count=3')  # 9개

sqldf('SELECT *
      FROM (SELECT * FROM Documents
      WHERE Docid=2 OR count=3)
      WHERE Docid=2 AND count=3')  # 이 하나의 행 때문에 위 두 쿼리의 결과가 다른 것


# SQL exercise 2
## Write query to count the number of documents containing the word "data"
sqldf('SELECT count(Docid) no_docs FROM Documents
      WHERE Term = "data"')
# Documents = rbind(Documents, c(6, 'data',3))
# sqldf('SELECT count(Docid) no_docs
#       FROM (SELECT DISTINCT Docid FROM Documents
#             WHERE Term = "data")')  # 만일의 중복 제거
## Answer
sqldf('SELECT count(*) FROM Documents
      WHERE Term = "data"')

# SQL exercise 3
## Write query to find all documents that have more than 3 terms
sqldf('SELECT Docid, count(Term) AS "no_Terms"
      FROM Documents
      GROUP BY Docid')
sqldf('SELECT Docid
      FROM (SELECT Docid, count(Term) AS "no_Terms"
      FROM Documents
      GROUP BY Docid)
      WHERE no_Terms > 3')
sqldf('SELECT Docid FROM Documents
      GROUP BY Docid
      HAVING count(Term) > 3')


# SQL exercise 4
## Write query to count the number of documents that contain both the word "data" and "base"
sqldf('SELECT Docid, Term FROM Documents
      WHERE Term = "data" OR Term = "base"')
sqldf('SELECT Docid
      FROM (SELECT Docid, Term FROM Documents
            WHERE Term="data" OR Term="base")
      GROUP BY Docid
      HAVING count(Docid)=2')

sqldf('SELECT Docid FROM Documents
      WHERE Term = "data" OR Term = "base"
      GROUP BY Docid
      HAVING count(Term)=2')


# SQL exercise 5
## Write query to compute the similarity of every pair of documents. The similarity here is computed by summing the same term counts of two documents.
sqldf('SELECT * FROM Documents a
      WHERE Docid=1')
sqldf('SELECT * FROM Documents a
      WHERE Docid=2')
sqldf('SELECT a.Docid AS "Doc_1",
              b.Docid AS "Doc_2",
              sum(a.count*b.count) AS "Similarity"
      FROM Documents a, Documents b
      WHERE a.Docid < b.Docid
            AND a.Term = b.Term
      GROUP BY a.Docid, b.Docid')
sqldf('SELECT a.Docid AS "Doc_1",
              b.Docid AS "Doc_2",
              sum(a.count*b.count) AS "Similarity"
      FROM Documents a
      JOIN Documents b ON a.Docid < b.Docid AND a.Term = b.Term
      GROUP BY a.Docid, b.Docid')
