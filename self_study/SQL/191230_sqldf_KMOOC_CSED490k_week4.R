# ref = "http://www.kmooc.kr/courses/course-v1:POSTECHk+CSED490k+2019_T1/course/"
# setwd("")
rm(list = ls())

library(sqldf)

# Aggregation - GROUP BY, HAVING
Bank = data.frame(Account = c(100090, 100091, 100092,
                              100093, 200010, 200011,
                              200012),
                  Branch = c('Seoul','Seoul','Busan',
                             'Seoul','New York',
                             'New York', 'Los Angeles'),
                  Country = c('Korea','Korea','Korea',
                              'Korea','USA','USA',
                              'USA'),
                  Balance = c(10000,7000,5000,9000,
                              20000,25000,30000))
sqldf('SELECT * FROM Bank')
sqldf('SELECT Branch, max(Balance) "max_Balance"
      FROM Bank
      GROUP BY Branch')
sqldf('SELECT Branch, sum(Balance) "sum_Balance"
      FROM Bank
      GROUP BY Branch
      HAVING sum_Balance > 10000')  # HAVING은 Aggregation 이후 결과값에 Condition을 적용할 때 사용


# Aggregation - ORDER BY
sqldf('SELECT Branch, sum(Balance) AS "sum_Balance"
      FROM Bank
      WHERE Country = "Korea"
      GROUP BY Branch
      HAVING sum_Balance > 10000
      ORDER BY sum_Balance ASC')


# Complicated SQL - Not run
## round(), cast( as type), floor()
## CASE ~ WHEN ~ THEN ~ END AS ~
## User-Defined Function

# sqldf('SELECT binid,
#             round(avg(cast(Fluo as float)), 3) as Fluo,
#             round(avg(cast(Oxygen as float)), 3) as Oxygen,
#             round(avg(cast(Nitrate_uM as float)), 3) as Nitrate_uM,
#             round(avg(cast(longitude as float)), 3) as longitude,
#             round(avg(cast(latitude as float)), 3) as latitude,
#       FROM (
#         SELECT *,
#               cast( floor(ts) +
#                     floor((ts-floor(ts))*24*60/binsize)
#                       *binsize/(24*60)
#                     as datetime ) as binid
#         FROM (
#           SELECT *,
#                 cast(timestamp as float) as ts,
#                 5.0 as binsize
#           FROM Tokyo_4_merged_data_time
#         ) x
#       ) bins
#       
#       GROUP BY binid
#       ORDER BY binid ASC
#       ')

# sqldf('
#       SELECT x.strain, x.chr,
#             x.region as snp_region,
#             x.start_bp as snp_start_bp,
#             x.end_bp as snp_en_bp,
#             w.start_bp as nc_start_bp,
#             w.end_bp as nc_en_bp,
#             w.category as nc_category,
#             CASE WHEN (x.start_bp >= w.start_bp AND
#                         x.end_bp <= w.end_bp)
#                   THEN x.end_bp - x.start_bp + 1
#                 WHEN (x.start_bp <= w.start_bp AND
#                         w.start_bp <= x.end_bp)
#                   THEN x.end_bp - w.start_bp + 1
#                 WHEN (x.start_bp <= w.end_bp AND
#                         w.end_bp <= x.end_bp)
#                   THEN w.end_bp - x.start_bp + 1
#             END AS len_overlap
#       FROM hotspots_deserts x
#       JOIN table_noncoding_positions w ON x.chr = w.chr
#       
#       WHERE ( x.start_bp >= w.start_bp AND 
#               x.end_bp <= w.end_bp)
#             OR ( x.start_bp <= w.start_bp AND 
#                  w.start_bp <= x.end_bp )
#             OR ( x.start_bp <= w.end_bp AND 
#                  w.end_bp <= x.end_bp )
#       ORDER BY x.strain, x.chr ASC, x.start_bp ASC
#       ')

# sqldf('
#       SELECT x.strain, x.chr,
#             x.region as snp_region,
#             x.start_bp as snp_start_bp,
#             x.end_bp as snp_en_bp,
#             w.start_bp as nc_start_bp,
#             w.end_bp as nc_en_bp,
#             w.category as nc_category,
#             len_overlap(x.start_bp, x.end_bp, w.start_bp, w.end_bp)   # user-defined-function
#       FROM hotspots_deserts x
#       JOIN table_noncoding_positions w ON x.chr = w.chr
# 
#       WHERE overlaps(x.start_bp, x.end_bp, w.start_bp, w.end_bp)   # user-defined-function
#       ORDER BY x.strain, x.chr ASC, x.start_bp ASC
#       ')


# Practice - extracting certain transaction using 3 tables
Product = data.frame(pid=c(100,200,300), 
                     name=c('p1','p2','p3'), 
                     price=c(100, 200, 300))
Purchase = data.frame(pid=c(100,200,300), 
                      cid=c(1,2,1), 
                      store=c('s1','s2','s3'))
Customer = data.frame(cid=c(1,2), 
                       name=c('c1','c2'), 
                       city=c('seattle','seoul'))
sqldf('SELECT DISTINCT x.name product, z.name customer
      FROM Product x, Purchase y, Customer z
      WHERE x.pid = y.pid AND
            y.cid = z.cid AND
            x.price > 100 AND
            z.city = "seattle"')


# CREATE VIEW (name) AS
sqldf(c('CREATE VIEW StorePrice AS
      SELECT x.store, y.price
      FROM Purchase x, Product y
      WHERE x.pid = y.pid',
        
      'SELECT * FROM StorePrice'))


# using VIEW
sqldf(c('CREATE VIEW StorePrice AS
      SELECT x.store, y.price
        FROM Purchase x, Product y
        WHERE x.pid = y.pid',
        
        'SELECT DISTINCT c.name, sp.store
        FROM Customer c, StorePrice sp, Purchase p
        WHERE c.cid = p.cid AND
              p.store = sp.store AND
              sp.price >= 200'))


# CREATE INDEX (attr_name) ON (table) - Not Run
sqldf(c('CREATE INDEX p_index ON Product (pid)',
        'SELECT pid FROM Product'))
