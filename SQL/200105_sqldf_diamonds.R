# ref = "https://redhorse046.tistory.com/22"
# solving dplyr exercise using sqldf

# setwd("")
rm(list = ls())

library(sqldf)
library(ggplot2)
library(dplyr)
data(diamonds)

# 1. check data
sqldf('SELECT count(*) FROM diamonds')
sqldf('SELECT * FROM diamonds LIMIT 5')


# 2. filter in sql
sqldf('SELECT * FROM diamonds WHERE price <= 950 LIMIT 20')
sqldf('SELECT * FROM diamonds WHERE price >= 800 and price <=950 LIMIT 10')


# 3. rename in sql
sqldf('SELECT carat, cut, color, clarity, depth, "table", price, 
              x AS "width", y AS "length", z AS "height"
      FROM diamonds LIMIT 5')


# 4. mutate in sql
sqldf('SELECT count(*) FROM diamonds WHERE "price" >= 3933')
sqldf('SELECT count(*) FROM diamonds')

sqldf('SELECT price, CASE WHEN "price" >= 3933 THEN "expensive"
                          ELSE "cheap"
                          END AS "price2"
      FROM diamonds
      LIMIT 5')
sqldf('SELECT *
      FROM (SELECT *, CASE WHEN "price" >= 3933 THEN "expensive"
                            ELSE "cheap"
                            END AS "price2"
            FROM diamonds)
      WHERE price2 = "expensive"
      ORDER BY price DESC
      LIMIT 5')
# diamonds %>% filter(price>=3933) %>% arrange(desc(price)) %>% head(5)
sqldf('SELECT *, CASE WHEN price >= 5324 THEN "high"
                      WHEN price < 5324 AND price >= 950 THEN "middle"
                      ELSE "low"
                      END AS "price3"
      FROM diamonds
      WHERE price3 = "middle"
      LIMIT 5')


# 5. summarize in sql


# 6. group_by in sql


# 7. arrange in sql


# 8. sample in sql

